
import '../../../core/common/model/rider.dart';

class JoinRideReqResponse {
  final List<Rider> joinedRider;
  JoinRideReqResponse({
    required this.joinedRider,
  });

  factory JoinRideReqResponse.fromJson(Map<String, dynamic> json) {
    return JoinRideReqResponse(
      joinedRider: (json["ride"]['participants'] as List<dynamic>).map((e)=> Rider.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'JoinRideReqResponse(joinedRide: ${joinedRider.toString()})';
  }

}