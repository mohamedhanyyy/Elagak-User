import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../cubit/states.dart';
import '../../cubit/home_cubit.dart';
import 'menu_item.dart';

class MenuItems {
  static const homepage = MyMenuItem('الصفحة الرئيسية', Icons.home);
  static const appStore = MyMenuItem('متجر علاجك', Icons.store_rounded);
  static const Profile = MyMenuItem('البروفايل', Icons.person);

  // static const Points = MyMenuItem('النقاط', Icons.control_point_sharp);
  static const Orders = MyMenuItem('الطلبات', Icons.shopping_cart);
  static const TopUsers =
      MyMenuItem('العملاء المميزين', Icons.control_point_sharp);
  static const Complients = MyMenuItem('الشكاوى', Icons.note_add);
  static const AboutUs = MyMenuItem('عن الابليكشن', Icons.info);
  static const ContactUs = MyMenuItem('اتصل بنا', Icons.call);

  static const all = <MyMenuItem>[
    homepage,
    appStore,
    Profile,
    // Points,
    Orders,
    TopUsers,
    Complients,
    AboutUs,
    ContactUs,
  ];
}

class MenuScreen extends StatelessWidget {
  final MyMenuItem currentItem;
  final ValueChanged<MyMenuItem> onSelectedItem;

  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  Widget buildMenuItem(MyMenuItem item) => ListTileTheme(
        selectedColor: Colors.grey[200],
        child: ListTile(
          selectedColor: Colors.white,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: HexColor("#04914F"),
              body: SafeArea(
                  child: Column(
                children: [
                  const Spacer(),
                  ...MenuItems.all.map(buildMenuItem).toList(),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              )),
            ));
      },
    );
  }
}
