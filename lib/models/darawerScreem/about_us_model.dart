class AboutUsModel {
  AboutUsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory AboutUsModel.fromJson(Map<String, dynamic>? json) => AboutUsModel(
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
    this.facebook,
    this.instagram,
    this.whatsapp,
    this.gmail,
    this.phone,
    this.aboutUs,
    this.ourVision,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.address,
  });

  int? id;
  String? facebook;
  String? instagram;
  String? whatsapp;
  String? gmail;
  String? phone;
  String? aboutUs;
  String? ourVision;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? latitude;
  double? longitude;
  String? address;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        whatsapp: json["whatsapp"],
        gmail: json["gmail"],
        phone: json["phone"],
        aboutUs: json["about_us"],
        ourVision: json["our_vision"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "facebook": facebook,
        "instagram": instagram,
        "whatsapp": whatsapp,
        "gmail": gmail,
        "phone": phone,
        "about_us": aboutUs,
        "our_vision": ourVision,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };
}
