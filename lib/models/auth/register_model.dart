class RegisterModel {
  RegisterModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  RegisterModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    code = json?['code'];
    msg = json?['msg'];
    data = Data.fromJson(json?['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;

  Data.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    token = json?['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['token'] = token;
    return _data;
  }
}
