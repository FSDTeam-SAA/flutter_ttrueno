
import '../../../core/common/model/rider.dart';

class JoinRideReqResponse {
  final Rider joinedRider;
  JoinRideReqResponse({
    required this.joinedRider,
  });

  factory JoinRideReqResponse.fromJson(Map<String, dynamic> json) {
    return JoinRideReqResponse(
      joinedRider: Rider.fromJson((json["ride"]['participants'] as List).last),
    );
  }

  @override
  String toString() {
    return 'JoinRideReqResponse(joinedRide: ${joinedRider.toString()})';
  }

}