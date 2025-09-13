import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';
import 'package:ttrueno_fo827e642a0c4/modules/search/model/ride_model.dart';

class CreateNotificationModel {
  final UserProfile user;
  final String body;
  final RideModel ride;
  final String message;
  final bool isRead;
  final String expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  CreateNotificationModel({
    required this.user,
    required this.body,
    required this.ride,
    required this.message,
    required this.isRead,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });


  factory CreateNotificationModel.fromJson(Map<String, dynamic> json) {
    return CreateNotificationModel(
      user: UserProfile.fromJson(json['user']),
      body: json['body'] ?? '',
      ride: RideModel.fromJson(json['ride']),
      message: json['message'] ?? '',
      isRead: json['isRead'] ?? false,
      expiresAt: json['expiresAt'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'body': body,
      'ride': ride.toJson(),
      'message': message,
      'isRead': isRead,
      'expiresAt': expiresAt,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
