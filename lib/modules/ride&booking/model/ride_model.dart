import 'package:ttrueno_fo827e642a0c4/core/common/model/rider.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/status.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/filter_model.dart';

import '../../location/model/location_address.dart';

class RideModel {
  final String id;
  final UserProfile creator;
  final LocationAdress startLocation;
  final LocationAdress endLocation;
  final DateTime departureTime;
  final num seatCount;
  final num bookedSeats;
  final FilterModel filters;
  final Status status;
  final bool deletedByCreator;
  final num price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String chatRoomId;
  final List<Rider> participants;

  RideModel({
    required this.id,
    required this.creator,
    required this.startLocation,
    required this.endLocation,
    required this.departureTime,
    required this.seatCount,
    required this.bookedSeats,
    required this.filters,
    required this.status,
    required this.deletedByCreator,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.chatRoomId,
    required this.participants,
  });


  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'] as String,
      creator: UserProfile.fromJson(json['creator']),
      startLocation: LocationAdress.fromJson(json['startLocation']),
      endLocation: LocationAdress.fromJson(json['endLocation']),
      departureTime: DateTime.parse(json['departureTime']),
      seatCount: json['seatCount'] as num,
      bookedSeats: json['bookedSeats'] as num,
      filters: FilterModel.fromJson(json['filters']),
      status: json['status'],
      deletedByCreator: json['deletedByCreator'] ?? false,
      price: json['price'] as num,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      chatRoomId: json['chatRoom'] ?? json['chatRoom']['_id'],
      participants: json['participants'] != null ? List<Rider>.from(json['participants'].map((x) => Rider.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator.toJson(),
      'startLocation': startLocation.toJson(),
      'endLocation': endLocation.toJson(),
      'departureTime': departureTime.toIso8601String(),
      'seatCount': seatCount,
      'bookedSeats': bookedSeats,
      'filters': filters.toJson(),
      'status': status,
      'deletedByCreator': deletedByCreator,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'chatRoom': chatRoomId,
      'participants': participants.map((x) => x.toJson()).toList(),
    };
  }
}


