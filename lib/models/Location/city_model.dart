class AllCitiesModel {
  AllCitiesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Data>? data;

  AllCitiesModel.fromJson(Map<String, dynamic>? json) {
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
  });

  int? id;
  String? name;

  Data.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
