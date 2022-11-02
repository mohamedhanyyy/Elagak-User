class VerifyEmailModel {
  VerifyEmailModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  VerifyEmailModel.fromJson(Map<String, dynamic>? json) {
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
    this.emailVerifiedAt,
    this.active,
    this.verifyCode,
    this.deviceToken,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.photo,
    this.token,
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic emailVerifiedAt;
  dynamic active;
  dynamic verifyCode;
  dynamic deviceToken;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic photo;
  dynamic token;

  Data.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    emailVerifiedAt = json?['email_verified_at'];
    active = json?['active'];
    verifyCode = json?['verify_code'];
    deviceToken = json?['device_token'];
    rememberToken = json?['remember_token'];
    createdAt = json?['created_at'];
    updatedAt = json?['updated_at'];
    deletedAt = json?['deleted_at'];
    photo = json?['photo'];
    token = json?['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['active'] = active;
    _data['verify_code'] = verifyCode;
    _data['device_token'] = deviceToken;
    _data['remember_token'] = rememberToken;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    _data['photo'] = photo;
    _data['token'] = token;
    return _data;
  }
}
