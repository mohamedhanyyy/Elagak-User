class TopFanModel {
  TopFanModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Data>? data;

  TopFanModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    code = json?['code'];
    msg = json?['msg'];
    data = List.from(json?['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    this.id,
    this.name,
    this.photo,
    this.purchaseTotal,
  });

  int? id;
  String? name;
  String? photo;
  String? purchaseTotal;

  Data.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    photo = json?['photo'];
    purchaseTotal = json?['purchase_total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['photo'] = photo;
    _data['purchase_total'] = purchaseTotal;
    return _data;
  }
}
