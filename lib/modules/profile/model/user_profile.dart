class UserProfile {
  final String id;
  final String name;
  final String email;
  final String number;
  final String imageUrl;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.imageUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      number: (json['number'] ?? '').toString(),
      imageUrl: (json['profileImage'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'number': number,
        'profileImage': imageUrl,
      };

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? number,
    String? imageUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
