class AddressResponse {
  AddressResponse({
      this.results, 
      this.status, 
      this.data,
  this.statusMsg});

  AddressResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    results = json['results'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  num? results;
  String? status;
  List<Data>? data;
  String? statusMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.name, 
      this.details, 
      this.phone, 
      this.city,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    details = json['details'];
    phone = json['phone'];
    city = json['city'];
  }
  String? id;
  String? name;
  String? details;
  String? phone;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['details'] = details;
    map['phone'] = phone;
    map['city'] = city;
    return map;
  }

}