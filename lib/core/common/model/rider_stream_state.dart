// import 'package:ttrueno_fo827e642a0c4/core/common/enum/rider_state.dart';
// import 'package:ttrueno_fo827e642a0c4/core/common/model/rider.dart';
// import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';

// class RiderStreamState extends Rider{
//   final String rideId;
//   final RiderState riderState;
//   RiderStreamState(
//     this.rideId,
//     this.riderState,{
//     required super.baggageType,
//     required super.userId,
//     required super.seatBooked,
//     required super.avgRating,
//     required super.name,
//     required super.profileImage,
//   });

//   factory RiderStreamState.fromJson(Map<String, dynamic> json) {
//     return RiderStreamState(
//       json['rideId'],
//       RiderState.fromString(json['riderState']),
//       baggageType: BaggageType.fromString(json['baggageType']),
//       userId: json['_id'],
//       name: json['name'],
//       email: json['email'],
//       number: json['number'],
//       imageUrl: json['imageUrl'],
//       rating: json['rating'].toDouble(),
//     );
//   }

// }