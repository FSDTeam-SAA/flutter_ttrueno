import 'package:ttrueno_fo827e642a0c4/modules/ride/model/location_address.dart';

class PostRideModel {
  LocationAdress? startLocation;
  LocationAdress? endLocation;
  String? departureTime;
  int? seatCount;
  String? pinnedNote;

  PostRideModel(
      {this.startLocation,
      this.endLocation,
      this.departureTime,
      this.seatCount,
      this.pinnedNote});

  PostRideModel.fromJson(Map<String, dynamic> json) {
    startLocation = json['startLocation'] != null
        ? LocationAdress.fromJson(json['startLocation'])
        : null;
    endLocation = json['endLocation'] != null
        ? LocationAdress.fromJson(json['endLocation'])
        : null;
    departureTime = json['departureTime'];
    seatCount = json['seatCount'];
    pinnedNote = json['pinnedNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (startLocation != null) {
      data['startLocation'] = startLocation!.toJson();
    }
    if (endLocation != null) {
      data['endLocation'] =endLocation!.toJson();
    }
    data['departureTime'] = departureTime;
    data['seatCount'] = seatCount;
    data['pinnedNote'] = pinnedNote;
    return data;
  }
}

