import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/status.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';

class Booking {
  final String id;
  final RideModel ride;
  final int seatBooked;
  final BaggageType baggageType;
  final Status status;
  final bool kicked;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.ride,
    required this.seatBooked,
    required this.baggageType,
    required this.status,
    required this.kicked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'] as String,
      ride: RideModel.fromJson(json['ride']),
      seatBooked: json['seatBooked'] as int,
      baggageType: BaggageType.fromString(json['baggageType']),
      status: Status.fromString(json['status']),
      kicked: json['kicked'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
