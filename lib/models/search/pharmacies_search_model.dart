class PharmaciesSearchModel {
  PharmaciesSearchModel({
    this.status,
    this.code,
    this.msg,
    this.paginate,
  });

  bool? status;
  int? code;
  String? msg;
  Paginate? paginate;

  PharmaciesSearchModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    code = json?['code'];
    msg = json?['msg'];
    paginate = Paginate.fromJson(json?['paginate']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['msg'] = msg;
    _data['paginate'] = paginate!.toJson();
    return _data;
  }
}

class Paginate {
  Paginate({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Paginate.fromJson(Map<String, dynamic>? json) {
    currentPage = json?['current_page'];
    data = List.from(json?['data']).map((e) => Data.fromJson(e)).toList();
    firstPageUrl = json?['first_page_url'];
    from = json?['from'];
    lastPage = json?['last_page'];
    lastPageUrl = json?['last_page_url'];
    links = List.from(json?['links']).map((e) => Links.fromJson(e)).toList();
    nextPageUrl = json?['next_page_url'];
    path = json?['path'];
    perPage = json?['per_page'];
    prevPageUrl = json?['prev_page_url'];
    to = json?['to'];
    total = json?['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data!.map((e) => e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['last_page_url'] = lastPageUrl;
    _data['links'] = links!.map((e) => e.toJson()).toList();
    _data['next_page_url'] = nextPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['prev_page_url'] = prevPageUrl;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class Data {
  Data({
    this.distance,
    this.id,
    this.name,
    this.phone1,
    this.phone2,
    this.photo,
    this.active,
    this.latitude,
    this.longitude,
    this.areaId,
    this.area,
  });

  dynamic distance;
  int? id;
  String? name;
  String? phone1;
  String? phone2;
  dynamic photo;
  bool? active;
  String? latitude;
  String? longitude;
  int? areaId;
  Area? area;

  Data.fromJson(Map<String, dynamic>? json) {
    distance = json?['distance'];
    id = json?['id'];
    name = json?['name'];
    phone1 = json?['phone1'];
    phone2 = json?['phone2'];
    photo = json?['photo'];
    active = json?['active'];
    latitude = json?['latitude'];
    longitude = json?['longitude'];
    areaId = json?['area_id'];
    area = Area.fromJson(json?['area']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance;
    _data['id'] = id;
    _data['name'] = name;
    _data['phone1'] = phone1;
    _data['phone2'] = phone2;
    _data['photo'] = photo;
    _data['active'] = active;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['area_id'] = areaId;
    _data['area'] = area!.toJson();
    return _data;
  }
}

class Area {
  Area({
    this.id,
    this.name,
    this.cityId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? cityId;
  String? createdAt;
  String? updatedAt;

  Area.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    cityId = json?['city_id'];
    createdAt = json?['created_at'];
    updatedAt = json?['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['city_id'] = cityId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Links {
  Links({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  Links.fromJson(Map<String, dynamic>? json) {
    url = json?['url'];
    label = json?['label'];
    active = json?['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}
