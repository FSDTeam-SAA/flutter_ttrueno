import 'package:ttrueno_fo827e642a0c4/modules/location/model/location_address.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';

class CreateRideReq {
  final LocationAdress startLocation;
  final LocationAdress endLocation;
  final DateTime departureTime;
  final int seatCount;
  final int seatAvailable;
  final String pinnedNote;
  final BaggageType baggageType;

  CreateRideReq({
    required this.startLocation,
    required this.endLocation,
    required this.departureTime,
    required this.seatCount,
    required this.seatAvailable,
    required this.pinnedNote,
    required this.baggageType,
  });

  Map<String, dynamic> toJson() {
    return {
      'startLocation': startLocation.toJson(),
      'endLocation': endLocation.toJson(),
      'departureTime': departureTime.toIso8601String(),
      'seatCount': 4,
      'seatAvailable': seatAvailable,
      'pinnedNote': pinnedNote,
      "baggageType": baggageType.name
    };
  }
}

