import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';

class ChatRoom {
  final String id;
  final String rideId;
  final String name;
  final bool isGroup;
  final String description;
  final List<UserProfile> participants;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatRoom({
    required this.id,
    required this.rideId,
    required this.name,
    required this.isGroup,
    required this.description,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as String,
      rideId: json['rideId'] as String,
      name: json['name'] as String,
      isGroup: json['isGroup'] as bool,
      description: json['description'] as String,
      participants: json['participants'] == null
          ? []
          : List<UserProfile>.from(
              json['participants']?.map((x) => UserProfile.fromJson(x)) ?? [],
            ),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'rideId': rideId,
        'name': name,
        'isGroup': isGroup,
        'description': description,
        'participants': participants.map((x) => x.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
