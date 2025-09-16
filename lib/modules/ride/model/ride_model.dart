import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/chat_room.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/filter_model.dart';

import 'location_address.dart';

class RideModel {
  final String id;
  final UserProfile creator;
  final LocationAdress startLocation;
  final LocationAdress endLocation;
  final DateTime departureTime;
  final int seatCount;
  final int bookedSeats;
  final FilterModel filters;
  final String status;
  final bool deletedByCreator;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ChatRoom chatRoom;

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
    required this.chatRoom,
  });


  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'] as String,
      creator: UserProfile.fromJson(json['creator']),
      startLocation: LocationAdress.fromJson(json['startLocation']),
      endLocation: LocationAdress.fromJson(json['endLocation']),
      departureTime: DateTime.parse(json['departureTime']),
      seatCount: json['seatCount'],
      bookedSeats: json['bookedSeats'],
      filters: FilterModel.fromJson(json['filters']),
      status: json['status'],
      deletedByCreator: json['deletedByCreator'] ?? false,
      price: json['price'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      chatRoom: ChatRoom.fromJson(json['chatRoom']),
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
      'chatRoom': chatRoom.toJson(),
    };
  }
}


