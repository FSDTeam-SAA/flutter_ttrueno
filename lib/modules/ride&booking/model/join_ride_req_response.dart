import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';

import '../../../core/common/model/rider.dart';

class JoinRideReqResponse {
  final Rider joinedRider;
  final ChatRoom chatRoom;
  JoinRideReqResponse({
    required this.joinedRider,
    required this.chatRoom,
  });

  factory JoinRideReqResponse.fromJson(Map<String, dynamic> json) {
    return JoinRideReqResponse(
      joinedRider: Rider.fromJson(json['joinedRider']),
      chatRoom: ChatRoom.fromJson(json['chatRoom']),
    );
  }

  @override
  String toString() {
    return 'JoinRideReqResponse(joinedRide: ${joinedRider.toString()}, chatRoom: ${chatRoom.toString()})';
  }

}