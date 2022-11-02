class OneOrderModel {
  OneOrderModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory OneOrderModel.fromJson(Map<String, dynamic>? json) => OneOrderModel(
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
    this.clientId,
    this.pharmacyId,
    this.deliveryId,
    this.deliveryType,
    this.paidType,
    this.description,
    this.photo,
    this.price,
    this.date,
    this.seen,
    this.type,
    this.status,
    this.latitude,
    this.longitude,
    this.address,
    this.couponId,
    this.couponAmount,
    this.priceAfterOffer,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.deliveryPrice,
    this.pharmacy,
    this.delivery,
    this.coupon,
    this.medicines,
  });

  int? id;
  int? clientId;
  int? pharmacyId;
  int? deliveryId;
  int? deliveryType;
  int? paidType;
  dynamic description;
  dynamic photo;
  String? price;
  String? date;
  int? seen;
  int? type;
  int? status;
  double? latitude;
  double? longitude;
  dynamic address;
  dynamic couponId;
  dynamic couponAmount;
  String? priceAfterOffer;
  String? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? deliveryPrice;
  Pharmacy? pharmacy;
  Delivery? delivery;
  dynamic coupon;
  List<Medicine>? medicines;

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        id: json?["id"],
        clientId: json?["client_id"],
        pharmacyId: json?["pharmacy_id"],
        deliveryId: json?["delivery_id"],
        deliveryType: json?["delivery_type"],
        paidType: json?["paid_type"],
        description: json?["description"],
        photo: json?["photo"],
        price: json?["price"],
        date: json?["date"],
        seen: json?["seen"],
        type: json?["type"],
        status: json?["status"],
        latitude:
            json?["latitude"] == null ? null : json?["latitude"].toDouble(),
        longitude:
            json?["longitude"] == null ? null : json?["longitude"].toDouble(),
        address: json?["address"],
        couponId: json?["coupon_id"],
        couponAmount: json?["coupon_amount"],
        priceAfterOffer: json?["price_after_offer"],
        createdAt: json?["created_at"],
        updatedAt: json?["updated_at"] == null
            ? null
            : DateTime.parse(json?["updated_at"]),
        deletedAt: json?["deleted_at"],
        deliveryPrice: json?["delivery_price"],
        pharmacy: json?["pharmacy"] == null
            ? null
            : Pharmacy.fromJson(json?["pharmacy"]),
        delivery: json?["delivery"] == null
            ? null
            : Delivery.fromJson(json?["delivery"]),
        coupon: json?["coupon"],
        medicines: json?["medicines"] == null
            ? null
            : List<Medicine>.from(
                json?["medicines"].map((x) => Medicine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "pharmacy_id": pharmacyId,
        "delivery_id": deliveryId,
        "delivery_type": deliveryType,
        "paid_type": paidType,
        "description": description,
        "photo": photo,
        "price": price,
        "date": date,
        "seen": seen,
        "type": type,
        "status": status,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "coupon_id": couponId,
        "coupon_amount": couponAmount,
        "price_after_offer": priceAfterOffer,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "delivery_price": deliveryPrice,
        "pharmacy": pharmacy == null ? null : pharmacy!.toJson(),
        "delivery": delivery == null ? null : delivery!.toJson(),
        "coupon": coupon,
        "medicines": medicines == null
            ? null
            : List<dynamic>.from(medicines!.map((x) => x.toJson())),
      };
}

class Delivery {
  Delivery({
    this.id,
    this.name,
    this.photo,
    this.phone,
  });

  int? id;
  String? name;
  dynamic photo;
  String? phone;

  factory Delivery.fromJson(Map<String, dynamic>? json) => Delivery(
        id: json?["id"],
        name: json?["name"],
        photo: json?["photo"],
        phone: json?["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "phone": phone,
      };
}

class Medicine {
  Medicine({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.active,
    this.departmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.price,
    this.pivot,
  });

  int? id;
  String? name;
  String? photo;
  String? description;
  int? active;
  int? departmentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? price;
  Pivot? pivot;

  factory Medicine.fromJson(Map<String, dynamic>? json) => Medicine(
        id: json?["id"],
        name: json?["name"],
        photo: json?["photo"],
        description: json?["description"],
        active: json?["active"],
        departmentId: json?["department_id"],
        createdAt: json?["created_at"] == null
            ? null
            : DateTime.parse(json?["created_at"]),
        updatedAt: json?["updated_at"] == null
            ? null
            : DateTime.parse(json?["updated_at"]),
        deletedAt: json?["deleted_at"],
        price: json?["price"],
        pivot: json?["pivot"] == null ? null : Pivot.fromJson(json?["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "active": active,
        "department_id": departmentId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "price": price,
        "pivot": pivot == null ? null : pivot?.toJson(),
      };
}

class Pivot {
  Pivot({
    this.orderId,
    this.medicineId,
    this.price,
    this.amount,
    this.id,
  });

  int? orderId;
  int? medicineId;
  String? price;
  int? amount;
  int? id;

  factory Pivot.fromJson(Map<String, dynamic>? json) => Pivot(
        orderId: json?["order_id"],
        medicineId: json?["medicine_id"],
        price: json?["price"],
        amount: json?["amount"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "medicine_id": medicineId,
        "price": price,
        "amount": amount,
        "id": id,
      };
}

class Pharmacy {
  Pharmacy({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Pharmacy.fromJson(Map<String, dynamic>? json) => Pharmacy(
        id: json?["id"],
        name: json?["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
