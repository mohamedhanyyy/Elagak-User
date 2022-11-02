class UpdateMessageModel {
  UpdateMessageModel({
    this.message,
    this.errors,
  });

  String? message;
  Errors? errors;

  UpdateMessageModel.fromJson(Map<String, dynamic>? json) {
    message = json?['message'];
    errors = Errors.fromJson(json?['errors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['errors'] = errors!.toJson();
    return _data;
  }
}

class Errors {
  Errors({
    this.name,
    this.email,
    this.phone,
  });

  List<String>? name;
  List<String>? email;
  List<String>? phone;

  Errors.fromJson(Map<String, dynamic>? json) {
    name = List.castFrom<dynamic, String>(json?['name']);
    email = List.castFrom<dynamic, String>(json?['email']);
    phone = List.castFrom<dynamic, String>(json?['phone']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    return _data;
  }
}
