class MyProfileModel {
  MyProfileModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory MyProfileModel.fromJson(Map<String, dynamic>? json) => MyProfileModel(
        status: json?["status"],
        code: json?["code"],
        msg: json?["msg"],
        data: json?["data"] == null ? null : Data.fromJson(json?["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
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
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  DateTime? emailVerifiedAt;
  int? active;
  dynamic verifyCode;
  String? deviceToken;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic photo;

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        id: json?["id"],
        name: json?["name"],
        email: json?["email"],
        phone: json?["phone"],
        emailVerifiedAt: json?["email_verified_at"] == null
            ? null
            : DateTime.parse(json?["email_verified_at"]),
        active: json?["active"],
        verifyCode: json?["verify_code"],
        deviceToken: json?["device_token"],
        rememberToken: json?["remember_token"],
        createdAt: json?["created_at"] == null
            ? null
            : DateTime.parse(json?["created_at"]),
        updatedAt: json?["updated_at"] == null
            ? null
            : DateTime.parse(json?["updated_at"]),
        deletedAt: json?["deleted_at"],
        photo: json?["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verified_at":
            emailVerifiedAt == null ? null : emailVerifiedAt!.toIso8601String(),
        "active": active,
        "verify_code": verifyCode,
        "device_token": deviceToken,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "photo": photo,
      };
}
