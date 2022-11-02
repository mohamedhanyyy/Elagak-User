// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:elagy_user_app/cubit/states.dart';
import 'package:elagy_user_app/models/auth/verify_model.dart';
import 'package:elagy_user_app/modules/auth/verification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import '../models/HomePage/all_pharmacies_model.dart';
import '../models/HomePage/one_pharmacy_model.dart';
import '../models/HomePage/pharmacy_medicines.dart';
import '../models/Location/city_model.dart';
import '../models/auth/login_model.dart';
import '../models/auth/profile_model.dart';
import '../models/auth/register_model.dart';
import '../models/auth/update_message_model.dart';
import '../models/auth/update_profile.dart';
import '../models/darawerScreem/about_us_model.dart';
import '../models/darawerScreem/order_model.dart';
import '../models/darawerScreem/top_fan.dart';
import '../models/orderModels/cart_list_model.dart';
import '../models/orderModels/one_order_model.dart';
import '../models/orderModels/send_order_model.dart';
import '../models/search/pharmacies_search_model.dart';
import '../models/search/search_model.dart';
import '../modules/DrawerScreens/about_us.dart';
import '../modules/DrawerScreens/complaints.dart';
import '../modules/DrawerScreens/contact_us.dart';
import '../modules/DrawerScreens/elagy_store.dart';
import '../modules/DrawerScreens/leader_board.dart';
import '../modules/DrawerScreens/one_order.dart';
import '../modules/DrawerScreens/orders.dart';
import '../modules/DrawerScreens/profile_data.dart';
import '../modules/HomePage/all_pharmacies.dart';
import '../modules/auth/login.dart';
import '../shared/constant.dart';
import '../shared/drawer/home_drawer.dart';
import '../shared/drawer/menu_item.dart';
import '../shared/drawer/menu_screen.dart';
import '../shared/navigation/navigation.dart';
import '../shared/network/global/http_helper.dart';
import '../shared/network/local/cache_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  String api = "https://elagkapp.com/api/v1/";

  getScreen(MyMenuItem currentItem) {
    switch (currentItem) {
      case MenuItems.homepage:
        return PharmaciesScreen();
      // case MenuItems.Points:
      //   return Points();
      case MenuItems.Orders:
        return PreviousOrder();
      case MenuItems.ContactUs:
        return const ContactUsScreen();
      case MenuItems.AboutUs:
        return const AboutUsScreen();
      case MenuItems.Profile:
        return const ProfileData();
      case MenuItems.Complients:
        return ComplaintsScreen();
      case MenuItems.TopUsers:
        return const LeaderBoard();
      case MenuItems.appStore:
        return const ElagyStore();
    }
  }

  bool isLoadingAuth = false;

  void loadingAuthScreens(bool value) {
    isLoadingAuth = value;
    emit(HomeLoadingAutScreensState());
  }

  bool isLoadingUpload = false;

  void loadingUploadImage(bool value) {
    isLoadingUpload = value;
    emit(HomeLoadingAutScreensState());
  }

  LoginModel? loginModel;

  Future<void> login(
      {required String password,
      required String email,
      required BuildContext context}) async {
    loadingAuthScreens(true);
    emit(HomeRegisterLoadingState());
    var DeviceToken = await FirebaseMessaging.instance.getToken();
    await http.post(Uri.parse('${api}client/login'), body: {
      'email': email,
      'password': password,
      'device_token': DeviceToken
    }, headers: {
      'Accept': 'application/json'
    }).then((value) {
      loginModel = LoginModel.fromJson(jsonDecode(value.body));
      print("login value.body : ${value.body}");
      if (loginModel!.code == 200) {
        print(loginModel!.data!.token.toString());
        var token = loginModel!.data!.token.toString();
        CacheHelper.putData(key: "token", value: token);
        loadingAuthScreens(false);
        navigateFinalTo(context, const HomeDrawer());
        UserOrders();
        getProfileData();
      } else if (loginModel!.code == 203) {
        CacheHelper.putData(key: "email", value: email);
        loadingAuthScreens(false);
        navigateFinalTo(context, Verificaton());
      } else {
        loadingAuthScreens(false);
        Fluttertoast.showToast(msg: "Try Again");
      }
      emit(HomeRegisterSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("login error is $e");
      }
      Fluttertoast.showToast(msg: "there is a something wrong, Try Again");
      loadingAuthScreens(false);
      emit(HomeRegisterErrorState());
    });
  }

  Future<void> UserOrders() async {
    emit(HomeGetCitiesLoadingState());
    var uri = Uri.parse('${api}orders');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      userModelOrders = UserModelOrders.fromJson(jsonDecode(value.body));
      debugPrint("UserOrders() done");
      debugPrint("UserOrders body with out encode ${value.body}");
      debugPrint("UserOrders body with encode ${jsonDecode(value.body)}");
      userModelOrders!.data!
          .sort(((b, a) => a.createdAt!.compareTo(b.createdAt!)));
      emit(HomeGetCitiesSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("UserOrders error is $e");
      }
      Fluttertoast.showToast(msg: '$e');
      emit(HomeGetCitiesErrorState());
    });
  }

  RegisterModel? registerModel;

  Future<void> register(BuildContext context, String name, String email,
      String password, String phone) async {
    loadingAuthScreens(true);
    emit(HomeRegisterLoadingState());
    var DeviceToken = await FirebaseMessaging.instance.getToken();
    await http.post(Uri.parse('${api}client/register'), body: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'device_token': DeviceToken
    }, headers: {
      'Accept': 'application/json'
    }).then((value) {
      registerModel = RegisterModel.fromJson(jsonDecode(value.body));
      emit(HomeRegisterLoadingState());
      if (registerModel!.code == 200) {
        Fluttertoast.showToast(msg: "تم إنشاء الحساب بنجاح");
        CacheHelper.putData(key: "token", value: registerModel!.data!.token);
        loadingAuthScreens(false);
        navigateTo(context, const HomeDrawer());
        UserOrders();
        getProfileData();
      } else if (registerModel!.code == 203) {
        Fluttertoast.showToast(msg: "برجاء تفعيل الحساب اولا");
        CacheHelper.putData(key: "email", value: email);
        loadingAuthScreens(false);
        navigateTo(context, Verificaton());
      } else {
        Fluttertoast.showToast(
            msg: 'البريد الالكتروني او رقم الهاتف مسجل من قبل');
        loadingAuthScreens(false);
        emit(HomeRegisterErrorState());
      }
      emit(HomeRegisterSuccessState());
    }).catchError((e) {
      loadingAuthScreens(false);
      if (kDebugMode) {
        print("register error is : $e");
      }
      emit(HomeRegisterErrorState());
    });
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    loadingAuthScreens(true);
    emit(HomeRegisterLoadingState());
    await http.post(Uri.parse('${api}password/reset'), body: {
      'email': email,
    }, headers: {
      'Accept': 'application/json',
    }).then((value) {
      if (jsonDecode(value.body)['code'] == 201) {
        Fluttertoast.showToast(msg: jsonDecode(value.body)['msg'].toString());
        loadingAuthScreens(false);
        navigateFinalTo(context, LoginScreenUser());
        emit(HomeRegisterSuccessState());
      } else {
        Fluttertoast.showToast(msg: "The selected email is invalid.");
        loadingAuthScreens(false);
        if (kDebugMode) {
          print("reseted email is : $email");
        }
        emit(HomeRegisterErrorState());
      }
    }).catchError((e) {
      loadingAuthScreens(false);
      if (kDebugMode) {
        print("resetPassword error is $e");
      }
      Fluttertoast.showToast(msg: "The selected email is invalid.");
      emit(HomeRegisterErrorState());
    });
  }

  VerifyEmailModel? verifyEmailModel;

  Future<void> VerifyEmail(
      {required String code, required BuildContext context}) async {
    loadingAuthScreens(true);
    emit(VerifyEmailLoadingState());
    await http.post(Uri.parse('${api}email/verify'), body: {
      'email': CacheHelper.getData(key: "email"),
      'code': code,
    }, headers: {
      'Accept': 'application/json',
    }).then((value) {
      verifyEmailModel = VerifyEmailModel.fromJson(jsonDecode(value.body));
      Fluttertoast.showToast(msg: "تم تفعيل الحساب بنجاح");
      CacheHelper.putData(key: "token", value: verifyEmailModel!.data!.token);
      loadingAuthScreens(false);
      navigateTo(context, const HomeDrawer());
      UserOrders();
      getProfileData();
      emit(VerifyEmailSuccessState());
    }).catchError((e) {
      loadingAuthScreens(false);
      if (kDebugMode) {
        print("VerifyEmail error is $e");
      }
      Fluttertoast.showToast(msg: "Check Your Internet Connection");
      emit(VerifyEmailErrorState());
    });
  }

  AllPharmaciesModel? allPharmaciesModel;
  OnePharmacyModel? onePharmacyModel;
  bool isPaginationMedicinesLoading = false;
  PharmacyMedicinesModel? pharmacyMedicinesModel;

  Future<void> getMedicines(int page, bool isPagination, String departmentId,
      String pharmacyId) async {
    if (isPagination) {
      isPaginationMedicinesLoading = true;
    } else {
      pharmacyMedicinesModel = null;
    }
    emit(HomeGetPharmacyMedicinesLoadingState());
    await HttpHelper.getDataWithQuery('pharmacy-medicines', {
      'page': page.toString(),
      'department_id': departmentId,
      'pharmacy_id': pharmacyId
    }).then((value) async {
      if (kDebugMode) {
        print("getMedicines is : $value");
      }
      if (isPagination) {
        pharmacyMedicinesModel!.paginate!.currentPage =
            value['paginate']['current_page'];
        value['paginate']['data'].forEach((e) {
          pharmacyMedicinesModel!.paginate!.data!
              .add(DatumPharmacyMed.fromJson(e));
        });
        isPaginationMedicinesLoading = false;
      } else {
        pharmacyMedicinesModel = PharmacyMedicinesModel.fromJson(value);
      }
      emit(HomeGetPharmacyMedicinesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print("getMedicines error is $error");
      }
      isPaginationMedicinesLoading = false;
      Fluttertoast.showToast(msg: 'error');

      emit(HomeGetPharmacyMedicinesErrorState());
    });
  }

  bool isElaghStorePaginationMedicinesLoading = false;
  PharmacyMedicinesModel? elagkStoreModel;

  Future<void> getElagyStoreMedicines(
      int page, bool isPagination, String departmentId) async {
    if (isPagination) {
      isElaghStorePaginationMedicinesLoading = true;
    } else {
      elagkStoreModel = null;
    }
    emit(HomeGetPharmacyMedicinesLoadingState());
    await HttpHelper.getDataWithQuery('pharmacy-medicines', {
      'page': page.toString(),
      'department_id': departmentId,
      'pharmacy_id': "10001"
    }).then((value) async {
      if (kDebugMode) {
        print("getElagyStoreMedicines is : $value");
      }
      if (isPagination) {
        elagkStoreModel!.paginate!.currentPage =
            value['paginate']['current_page'];
        value['paginate']['data'].forEach((e) {
          elagkStoreModel!.paginate!.data!.add(DatumPharmacyMed.fromJson(e));
        });
        isElaghStorePaginationMedicinesLoading = false;
      } else {
        elagkStoreModel = PharmacyMedicinesModel.fromJson(value);
      }
      emit(HomeGetPharmacyMedicinesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print("getElagyStoreMedicines error is $error");
      }
      isElaghStorePaginationMedicinesLoading = false;
      Fluttertoast.showToast(msg: 'error');

      emit(HomeGetPharmacyMedicinesErrorState());
    });
  }

  Future getCategories(String phId) async {
    onePharmacyModel = null;
    emit(HomeGetPharmaciesCatsLoadingState());
    await HttpHelper.getData('pharmacy/$phId').then((value) {
      onePharmacyModel = OnePharmacyModel.fromJson(value);
      emit(HomeGetPharmaciesCatsSuccessState());
      getMedicines(
          1,
          false,
          onePharmacyModel!.data!.departments![0].id.toString(),
          onePharmacyModel!.data!.id.toString());
    }).catchError((e) {
      if (kDebugMode) {
        print("getCategories error is : $e");
      }
      emit(HomeGetPharmaciesCatsErrorState());
    });
  }

  launchMap({required String lat, required String lng}) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void openFaceBook(String pageLink) async {
    var url = 'fb://facewebmodal/f?href=$pageLink';
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  void whatsAppOpen(String number) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+2$number/?text=${Uri.encodeFull("مرحبَا، هل يمكنك إخباري بمواعيد العمل الخاصة بك؟")}";
      } else {
        return "whatsapp://send?phone=+2$number&text=${Uri.encodeFull("مرحبَا، هل يمكنك إخباري بمواعيد العمل الخاصة بك؟")}";
      }
    }

    launchUrl(Uri.parse(url()));
  }

  sendingMails(String url) async {
    url = 'mailto:feedback@${url}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchInstagram(String? username, String profileLink) async {
    String nativeUrl = "instagram://user?username=$username";
    String webUrl = profileLink;
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("can't open Instagram");
    }
  }

  int selectedCategoryIndex = 0;

  void changeCatIndex(int index) {
    selectedCategoryIndex = index;
    emit(HomeChangeCatIndexState());
    getMedicines(
        1,
        false,
        onePharmacyModel!.data!.departments![index].id.toString(),
        onePharmacyModel!.data!.id.toString());
  }

  SearchModel? searchModel;

  Future<void> newSearch(String text, String id) async {
    emit(HomePharmaciesSearchLoadingState());
    await HttpHelper.getDataWithQuery(
        'search/pharmacy/$id', {'search': text.toString()}).then((value) {
      searchModel = SearchModel.fromJson(value);
      emit(HomePharmaciesSearchSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("newSearch error is $e");
      }
      Fluttertoast.showToast(msg: 'لا يمكن تنفيذ طليك حاليا');
      emit(HomePharmaciesSearchErrorState());
    });
  }

  late Database database;
  List<dynamic> myItems = [];

  createDataBase() async {
    //openDatabase(path,on create ,on open ) function that within it , we create db and create table an open db
    await openDatabase('CartItems.db', version: 5, onCreate: (db, version) {
      emit(CreateDataBaseState());
      debugPrint(
          'Database is created and given me object of it is called db and version $version');
      db
          .execute(
              'CREATE TABLE Products (id INTEGER PRIMARY KEY, title TEXT, price INT , image TEXT, quantity INT, pharmacyid INT, medicineID INT)')
          .then((value) {
        emit(CreateDataBaseState());
        debugPrint('table is created');
      }).catchError((onError) {
        debugPrint('createDataBase error is ${onError.toString()}');
        emit(CreateDataBaseState());
      }); //create table
    }, onOpen: (db) {
      debugPrint('db is opened\nGet Data from table Done');
      emit(CreateDataBaseState());
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    }).catchError((e) {
      debugPrint("Create DataBase is $e");
      emit(CreateDataBaseState());
    });
  }

  late int totalPrice = 0;

  // insert into DB
  insertToDatabase(
      {required String title,
      required String price,
      required String image,
      required int quantity,
      required int pharmacyID,
      required int medicineID}) {
    database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO Products(title, price, image, quantity, pharmacyid, medicineID) VALUES("$title", "$price", "$image", "$quantity", "$pharmacyID", "$medicineID")');
    }).then((value) {
      debugPrint('data inserted $value');
      getDataFromDataBase(pharmacyID);
      emit(InsertDataBaseState());
    }).catchError((e) {
      debugPrint("inseart DataBase is $e");
      emit(CreateDataBaseState());
    });
  }

  // Get Data From DB
  getDataFromDataBase(int pharmacyID) async {
    myItems.clear();
    await database.rawQuery("SELECT * FROM Products  WHERE pharmacyid = ?",
        [pharmacyID]).then((value) {
      for (var element in value) {
        myItems.add(element);
      }
      debugPrint("my list item is ${myItems.toList().toString()}");
      emit(GetFromDataBaseState());
    }).catchError((e) {
      debugPrint("getDataFromDataBase is $e");
      emit(GetFromDataBaseState());
    });
  }

  // Delete All Of DB
  delete() async => await deleteDatabase('CartItems.db')
      .then((value) => debugPrint('CartItems.db deleted'));

  // Delete Row in DB
  deleteRow(
      {required int id, required int index, required int pharmacyID}) async {
    emit(DeleteDataBaseState());
    // Update some record
    await database
        .rawDelete('DELETE FROM Products WHERE id = ?', [id]).then((value) {
      totalPrice -= (myItems[index]["price"]) as int;
      getDataFromDataBase(pharmacyID);
      emit(DeleteDataBaseState());
    }).catchError((e) {
      debugPrint("deleteRow error is $e");
      emit(DeleteDataBaseState());
    });
  }

  updateQuery(int amount, int id, int pharID) async {
    emit(HomeEditCartState());
    if (amount > 0) {
      await database.rawUpdate('UPDATE Products SET quantity = ? WHERE id = ?',
          [amount, id.toString()]).then((value) {
        debugPrint("update done");
        getDataFromDataBase(pharID);
        emit(HomeEditCartState());
      }).catchError((e) {
        debugPrint("update Query is : $e");
        emit(HomeEditCartState());
      });
    } else {
      Fluttertoast.showToast(msg: "لا يمكن شراء اقل من عدد 1 يمكنك حذف المنتج");
      emit(HomeEditCartState());
    }
  }

  // Delete Row in DB
  deleteRowCart({required int id}) async {
    emit(DeleteDataBaseState());
    await database.rawDelete(
        'DELETE FROM Products WHERE pharmacyid = ?', [id]).then((value) {
      getDataFromDataBase(id);
      emit(DeleteDataBaseState());
    }).catchError((e) {
      debugPrint("deleteRow error is $e");
      emit(DeleteDataBaseState());
    });
  }

  late String adrees;

  changeAdress(String newAdress) {
    adrees = newAdress;
    emit(ChangeAdressState());
  }

  XFile? image;
  String? imageePAth;

  Future pickImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      } else {
        imageePAth = image!.path;
        // final imageTemp = File(image!.path);
        // imageFile = imageTemp;
        emit(TakePhotoState());
      }
    } on PlatformException catch (e) {
      print("pickImage error is $e");
      Fluttertoast.showToast(msg: "Failed to pick image $e");
      emit(TakePhotoErrorState());
    }
  }

  // make order
  upload(
      {required String latitude,
      required String longitude,
      required String adress,
      required String pharmacyId,
      String? description,
      String? imageFile,
      required BuildContext context}) async {
    loadingUploadImage(true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${api}order/storeText'));
    request.fields.addAll({
      'latitude': latitude,
      'longitude': longitude,
      'address': adress,
      'pharmacy_id': pharmacyId
    });
    if (description!.isNotEmpty) {
      debugPrint("description legth is ${description.length}");
      debugPrint("descripation is not equal null");
      request.fields.addAll({'description': description});
    }
    if (imageFile != null) {
      debugPrint("image file is not equal null");
      request.files.add(await http.MultipartFile.fromPath('photo', imageFile));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("//////////////////////////////////////////////");
      debugPrint(await response.stream.bytesToString());
      debugPrint("//////////////////////////////////////////////");
      Fluttertoast.showToast(msg: "تم إرسال الطلب بنجاح");
      UserOrders();
      loadingUploadImage(false);
      navigateFinalTo(context, const HomeDrawer());
    } else {
      debugPrint("*****************error**********************");
      debugPrint(response.statusCode.toString());
      debugPrint(response.reasonPhrase);
      debugPrint(imageFile);
      debugPrint("***************************************");
      Fluttertoast.showToast(
          msg:
              "تأكد من وجود اتصال انترنت قوي\n يجب أن يزيد العنوان عن 10 أحرف \n يجب أن يزيد مربع الدواء عن 20 حرف");
      loadingUploadImage(false);
    }
  }

  static Future<bool> sendFcmMessage(String title, String message) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAy-xnneQ:APA91bEbIxxfGmNMrX-UvWZViMHgNuF9GTmLXaVP_uLAH1bXJ3o1I248wGzP1ZNHXjBegVCEqUsc4olP88xLOqBXuVbLK1LtGlX0L4Pg75gSyOfBYzR-eAokhPZtfQga9Xu_47irZcSE",
      };
      var request = {
        "notification": {
          "title": title,
          "text": message,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        "to":
            "dio5XpZgSBG4p3_BW-2_qP:APA91bG-m5KZEYWPKQNMsU5t0hXSIvmzo2RRLg8BQnLzmPM5gJ36qvwWyAxu0UHgGHpeyBkCJcgqpFbo6b3kfjOStqHPjOq6fUdtRzuSWfgIW1Aexmzl9iTZplqyYcztzjMlIo46ytMe",
      };
      await http.post(Uri.parse(url),
          headers: header, body: json.encode(request));
      return true;
    } catch (e, s) {
      print(e);
      return false;
    }
  }

  OneOrderModel? oneOrderModel;

  Future<void> getOneOrderData(String id, BuildContext context) async {
    emit(HomeRegisterLoadingState());
    await http.get(Uri.parse('${api}order/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (jsonDecode(value.body)['code'] == 200) {
        oneOrderModel = OneOrderModel.fromJson(jsonDecode(value.body));
        emit(HomeRegisterSuccessState());
        navigateTo(context, OneOrderDetails());
      } else {
        Fluttertoast.showToast(msg: "غير متاح حاليا");
        emit(HomeRegisterErrorState());
      }
    }).catchError((e) {
      debugPrint("getOneOrderData error is $e");
      Fluttertoast.showToast(msg: "يرجي المحاولة في وقت لاحق");
      emit(HomeRegisterErrorState());
    });
  }

  Future<void> refreshOneOrderData(String id) async {
    emit(HomeRegisterLoadingState());
    await http.get(Uri.parse('${api}order/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (jsonDecode(value.body)['code'] == 200) {
        oneOrderModel = OneOrderModel.fromJson(jsonDecode(value.body));
        emit(HomeRegisterSuccessState());
      } else {
        Fluttertoast.showToast(msg: "غير متاح حاليا");
        emit(HomeRegisterErrorState());
      }
    }).catchError((e) {
      debugPrint("getOneOrderData error is $e");
      Fluttertoast.showToast(msg: "يرجي المحاولة في وقت لاحق");
      emit(HomeRegisterErrorState());
    });
  }

  SendOrderData? sendOrderData;

  Future<void> cartOrder(
      {required String pharmacy_id,
      required int pharmID,
      required List<Map<String, dynamic>> medicines,
      String? coupon,
      required String addressdelv,
      required BuildContext context}) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${api}order/store'));
    for (int i = 0; i < medicines.length; i++) {
      request.fields.addAll({
        'medicines[$i][medicine_id]': medicines[i]['medicine_id'].toString(),
        'medicines[$i][amount]': medicines[i]['amount'].toString(),
      });
    }
    request.fields.addAll({
      'pharmacy_id': pharmacy_id,
      'latitude': latitude,
      'longitude': longitude,
      'coupon': coupon.toString(),
      'address': addressdelv.toString() ?? adrees
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("address controller is : ${addressdelv.toString()}");
      }
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
      navigateFinalTo(context, const HomeDrawer());
      Fluttertoast.showToast(msg: "تم إرسال طلبك بنجاح");
      UserOrders();
      int index = 0;
      for (var element in myItems) {
        deleteRowCart(id: pharmID);
      }
      emit(HomeGetAboutUsSuccessState());
    } else {
      print(response.reasonPhrase);
      emit(HomeGetAboutUsErrorState());
    }
  }

  String latitude = '00.00000';
  String longitude = '00.00000';

  AboutUsModel? aboutUsModel;

  Future getAboutUs() async {
    emit(HomeGetAboutUsLoadingState());
    await HttpHelper.getData('about_us').then((value) {
      aboutUsModel = AboutUsModel.fromJson(value);
      CacheHelper.getData(key: 'token') != null
          ? UserOrders()
          : print("not log in");
      CacheHelper.getData(key: 'token') != null
          ? getProfileData()
          : print("not log in");
      CacheHelper.getData(key: 'token') != null
          ? print("token is ${CacheHelper.getData(key: 'token')}")
          : print("not log in");
      emit(HomeGetAboutUsSuccessState());
    }).catchError((e) {
      print("getAboutUs error is : $e");
      emit(HomeGetAboutUsErrorState());
    });
  }

  Future contactUS(
      {required String email,
      required String name,
      required String phone,
      required String body,
      required String title,
      required BuildContext context}) async {
    emit(HomeRegisterLoadingState());
    await http.post(Uri.parse('${api}contact-us'), body: {
      'email': email,
      'name': name,
      'phone': phone,
      'body': body,
      'title': title
    }, headers: {
      'Accept': 'application/json'
    }).then((value) {
      if (jsonDecode(value.body)['code'] == 201) {
        Fluttertoast.showToast(msg: jsonDecode(value.body)['msg'].toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        myImage('assets/images/newlogo/3elagk WORD.png'),
                        const Text("شكرا لك يسعادنا دائما انك معانا",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              );
            });
        emit(HomeRegisterSuccessState());
      } else {
        Fluttertoast.showToast(msg: "برجاء ملئ جميع الحقول المطلوبة");
        emit(HomeRegisterErrorState());
      }
    }).catchError((e) {
      Fluttertoast.showToast(msg: "يرجي المحاولة في وقت لاحق");
      if (kDebugMode) {
        print("contactUS error is $e");
      }
      emit(HomeRegisterErrorState());
    });
  }

  UserModelOrders? userModelOrders;

  UpdateProfileResponse? updateProfileResponse;
  UpdateMessageModel? updateMessageModel;

  Future<void> updateProfile(
      {required String email,
      required String name,
      required String phone,
      required String password,
      String? profileImagePath,
      required BuildContext context}) async {
    emit(HomeRegisterLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${api}client/update'));
    request.fields.addAll({
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    });
    request.files
        .add(await http.MultipartFile.fromPath('photo', profileImagePath!));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Profile Updated");
      emit(HomeRegisterSuccessState());
      getProfileData();
      navigateTo(context, const ProfileData());
    } else {
      Fluttertoast.showToast(msg: "يجب ملئ جميع البيانات المطلوبة");
      emit(HomeRegisterErrorState());
    }
  }

  MyProfileModel? myProfileModel;

  Future<void> getProfileData() async {
    emit(HomeRegisterLoadingState());
    await http.get(Uri.parse('${api}profile/client'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      myProfileModel = MyProfileModel.fromJson(jsonDecode(value.body));
      if (kDebugMode) {
        print("myProfile Data is $myProfileModel");
      }
      if (kDebugMode) {
        print("myProfile value.body ${value.body}");
      }
      emit(HomeRegisterSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("getProfileData error is $e");
      }
      emit(HomeRegisterErrorState());
    });
  }

  XFile? profileImage;
  String? profileImageePAth;

  Future pickProfileImage() async {
    try {
      profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (profileImage == null) {
        return;
      } else {
        profileImageePAth = profileImage!.path;
        // final imageTemp = File(image!.path);
        // imageFile = imageTemp;
        emit(TakePhotoState());
      }
    } on PlatformException catch (e) {
      print("pickImage error is $e");
      Fluttertoast.showToast(msg: "Failed to pick image $e");
      emit(TakePhotoErrorState());
    }
  }

  Future<void> logOutAccount(BuildContext context) async {
    emit(HomeGetCitiesLoadingState());
    var uri = Uri.parse('${api}client/logout');
    await http.post(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      CacheHelper.deleteData('token');
      Fluttertoast.showToast(msg: "تم تسجيل الخروج بنجاح");
      navigateFinalTo(context, const HomeDrawer());
      emit(HomeGetCitiesSuccessState());
    }).catchError((e) {
      print("logOutAccount error is $e");
      Fluttertoast.showToast(msg: '$e');
      emit(HomeGetCitiesErrorState());
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    emit(HomeGetCitiesLoadingState());
    var uri = Uri.parse('${api}delete/profile');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      delete();
      logOutAccount(context);
      Fluttertoast.showToast(msg: "تم حذف جميع بياناتك بنجاح");
      navigateFinalTo(context, const HomeDrawer());
      emit(HomeGetCitiesSuccessState());
    }).catchError((e) {
      print("deleteAccount error is $e");
      Fluttertoast.showToast(msg: '$e');
      emit(HomeGetCitiesErrorState());
    });
  }

  AllCitiesModel? allCitiesModel;

  Future<void> getCities() async {
    emit(HomeGetCitiesLoadingState());
    await HttpHelper.getData('city').then((value) {
      allCitiesModel = AllCitiesModel.fromJson(value);
      emit(HomeGetCitiesSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("getCities error is $e");
      }
      Fluttertoast.showToast(msg: 'error');
      emit(HomeGetCitiesErrorState());
    });
  }

  bool isPaginationPharmaciesLoading = false;

  Future<void> getPharmacies(int page, bool isPagination) async {
    if (isPagination) {
      isPaginationPharmaciesLoading = true;
    } else {
      allPharmaciesModel = null;
    }
    emit(HomeGetPharmaciesSuccessState());
    await HttpHelper.getDataWithQuery('get-pharmacies', {
      'page': page.toString(),
      'latitude': latitude,
      'longitude': longitude
    }).then((value) async {
      if (kDebugMode) {
        print((value));
      }
      if (isPagination) {
        allPharmaciesModel!.data!.currentPage = value['data']['current_page'];
        value['data']['data'].forEach((e) {
          allPharmaciesModel!.data!.datason!.add(Datason.fromJson(e));
        });
        isPaginationPharmaciesLoading = false;
      } else {
        allPharmaciesModel = AllPharmaciesModel.fromJson(value);
      }

      emit(HomeGetPharmaciesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print("getPharmacies error is : $error");
      }
      isPaginationPharmaciesLoading = false;
      Fluttertoast.showToast(msg: 'error');

      emit(HomeGetPharmaciesErrorState());
    });
  }

  late List<Placemark> placemarks;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "من فضلك قم بتشغيل الموقع الجغرافي");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "من فضلك قم بتشغيل الموقع الجغرافي");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Fluttertoast.showToast(
          msg: "خدمات التطبيق تعمل من خلال تحديد الموقع الجغرافي");
    }

    await Geolocator.getCurrentPosition().then((value) async {
      latitude = value.latitude.toString();
      longitude = value.longitude.toString();
      placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      adrees =
          "${placemarks[0].country.toString()} - ${placemarks[0].administrativeArea.toString()} - ${placemarks[0].subAdministrativeArea.toString()}";
      if (kDebugMode) {
        print(adrees);
      }
      if (kDebugMode) {
        print("latitude is $latitude\nlongitude is $longitude");
      }
      emit(HomeGetLocationState());
      getPharmacies(1, false);
    }).catchError((e) {
      if (kDebugMode) {
        print("getCurrentLocation error is : $e");
      }
    });
  }

  TopFanModel? topFanModel;

  Future<void> getTopFan() async {
    emit(HomeGetTopFanLoadingState());
    await HttpHelper.getData('client/top-ten').then((value) {
      print(value);
      topFanModel = TopFanModel.fromJson(value);
      emit(HomeGetTopFanSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("getTopFan error is $e");
      }
      Fluttertoast.showToast(msg: 'error');
      emit(HomeGetTopFanErrorState());
    });
  }

  bool bought = false;

  void changeCartItemLable() {
    bought = !bought;
    emit(HomeLoadingAutScreensState());
  }

  PharmaciesSearchModel? pharmaciesSearchModel;

  Future<void> pharmaciesSearch({required String search}) async {
    emit(HomePharmaciesSearchLoadingState());
    await HttpHelper.getDataWithQuery(
        'search/pharmacy', {'search': search.toString()}).then((value) {
      pharmaciesSearchModel = PharmaciesSearchModel.fromJson(value);
      emit(HomePharmaciesSearchSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print("pharmaciesSearch error is $e");
      }
      Fluttertoast.showToast(msg: 'لا يمكن تنفيذ طليك حاليا');
      emit(HomePharmaciesSearchErrorState());
    });
  }

  CartListModel? cartListModel;

  List<String> types = ["Store", "Cosmetics"];
  List<String> images = [
    "https://drive.google.com/file/d/1s9HJLebEg9hbWTR_wVWgw5Z_fO3AHkpN/view?usp=sharing",
    "https://drive.google.com/file/d/1eL0XXxXaEqFLTIn8-t541sXpsbqejWyr/view?usp=sharing"
  ];

  int steperIndex = 0;
  bool _complete = false;

  List<Step> createSteps() => [
        Step(
          isActive: oneOrderModel!.data!.status == 1
              ? true
              : oneOrderModel!.data!.status == 3
                  ? true
                  : oneOrderModel!.data!.status == 5
                      ? true
                      : false,
          title: const Text('حالة الطلب'),
          subtitle: const Text("تم إرسال الطلب بنجاح"),
          state: oneOrderModel!.data!.status == 1
              ? StepState.complete
              : oneOrderModel!.data!.status == 3
                  ? StepState.complete
                  : oneOrderModel!.data!.status == 5
                      ? StepState.complete
                      : StepState.indexed,
          content: Column(
            children: [
              Text(
                  "السعر قبل الخصم : ${oneOrderModel!.data!.price.toString()}"),
              oneOrderModel!.data!.couponAmount == null
                  ? const Text("قيمة الخصم : لا يوجد")
                  : Text(
                      "قيمة الخصم : ${oneOrderModel!.data!.couponAmount.toString()}"),
              Text(
                  "السعر بعد الخصم : ${oneOrderModel!.data!.priceAfterOffer.toString()}"),
            ],
          ),
        ),
        Step(
          isActive: oneOrderModel!.data!.status == 1
              ? true
              : oneOrderModel!.data!.status == 2
                  ? true
                  : oneOrderModel!.data!.status == 5
                      ? true
                      : false,
          title: const Text('التجهيز'),
          subtitle: oneOrderModel!.data!.status == 1
              ? const Text("تم تجهيز الطلب بنجاح")
              : oneOrderModel!.data!.status == 3
                  ? const Text("تم تجهيز الطلب بنجاح")
                  : oneOrderModel!.data!.status == 5
                      ? const Text("تم تجهيز الطلب بنجاح")
                      : oneOrderModel!.data!.status == 4
                          ? const Text("الطلب مرفوض")
                          : const Text("جاري معالجة الطلب"),
          state: oneOrderModel!.data!.status == 1
              ? StepState.complete
              : oneOrderModel!.data!.status == 2
                  ? StepState.complete
                  : oneOrderModel!.data!.status == 5
                      ? StepState.complete
                      : StepState.indexed,
          content: Text("الصيدلية : ${oneOrderModel!.data!.pharmacy!.name}"),
        ),
        Step(
            isActive: oneOrderModel!.data!.status == 3
                ? true
                : oneOrderModel!.data!.status == 5
                    ? true
                    : false,
            title: const Text('التوصيل'),
            subtitle: oneOrderModel!.data!.status == 3
                ? const Text('الطلب في الطريق إليك')
                : oneOrderModel!.data!.status == 5
                    ? const Text('الطلب في الطريق إليك')
                    : const Text('سيتم توصيل الطلب في اسرع وقت ممكن'),
            state: oneOrderModel!.data!.status == 3
                ? StepState.complete
                : oneOrderModel!.data!.status == 5
                    ? StepState.complete
                    : StepState.indexed,
            content: Column(
              children: [
                oneOrderModel!.data!.delivery != null
                    ? Text("كابتن : ${oneOrderModel!.data!.delivery!.name}")
                    : const Text("كابتن : N/A"),
                oneOrderModel!.data!.delivery != null
                    ? Text(
                        "رقم الهاتف : ${oneOrderModel!.data!.delivery!.phone}")
                    : const Text("رقم الهاتف : N/A")
              ],
            )),
        Step(
          isActive: oneOrderModel!.data!.deliveryType == 1 ? true : false,
          title: const Text('التسليم'),
          subtitle: oneOrderModel!.data!.deliveryType == 1
              ? const Text("تم تسليم الطب")
              : const Text("جاري تجهيز الطلب و تسليمه في اسرع وقت ممكن"),
          state: StepState.disabled,
          content: const Text("سعداء بخدمتك"),
        ),
      ];

  CancleStep() {
    if (steperIndex > 0) {
      steperIndex -= 1;
      emit(CancleStepState());
    }
  }

  ContaineStep() {
    final isLastStep = steperIndex == createSteps().length - 1;
    if (isLastStep) {
      debugPrint('Completed all steps');
      debugPrint(steperIndex.toString());
      _complete = true;
      emit(ContaineStepSuccess());
    } else {
      steperIndex += 1;
      emit(ContaineStepFailed());
    }
  }

  TappedStep(int index) {
    steperIndex = index;
    emit(TappedStepState());
  }
}
