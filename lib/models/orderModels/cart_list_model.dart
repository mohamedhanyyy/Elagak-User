import 'dart:convert';

List<CartListModel> welcomeFromJson(String str) => List<CartListModel>.from(
    json.decode(str).map((x) => CartListModel.fromJson(x)));

String welcomeToJson(List<CartListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartListModel {
  CartListModel({
    this.medicineId,
    this.amount,
  });

  int? medicineId;
  int? amount;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        medicineId: json["medicine_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "medicine_id": medicineId,
        "amount": amount,
      };
}
