class LocationAdress {
  String? address;
  double? lat;
  double? lng;

  LocationAdress({this.address, this.lat, this.lng});

  LocationAdress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}