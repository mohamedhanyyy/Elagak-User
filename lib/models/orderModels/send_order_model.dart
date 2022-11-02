class SendOrderData {
  SendOrderData({
    this.pharmacyId,
    this.medicines,
    this.latitude,
    this.longitude,
  });

  int? pharmacyId;
  List<Medicines>? medicines;
  double? latitude;
  double? longitude;

  SendOrderData.fromJson(Map<String, dynamic>? json) {
    pharmacyId = json?['pharmacy_id'];
    medicines = List.from(json?['medicines'])
        .map((e) => Medicines.fromJson(e))
        .toList();
    latitude = json?['latitude'];
    longitude = json?['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pharmacy_id'] = pharmacyId;
    _data['medicines'] = medicines!.map((e) => e.toJson()).toList();
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}

class Medicines {
  Medicines({
    this.medicineId,
    this.amount,
  });

  int? medicineId;
  int? amount;

  Medicines.fromJson(Map<String, dynamic>? json) {
    medicineId = json?['medicine_id'];
    amount = json?['amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['medicine_id'] = medicineId;
    _data['amount'] = amount;
    return _data;
  }
}
