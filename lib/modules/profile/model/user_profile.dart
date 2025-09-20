class UserProfile {
  final String id;
  final String name;
  final String email;
  final String number;
  final String imageUrl;
  final num rating;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.imageUrl,
    required this.rating, 
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      imageUrl: json['profileImage'] ?? '',
      rating: json["rating"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'number': number,
        'profileImage': imageUrl,
        'rating': rating
      };

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? number,
    String? imageUrl,
    num? rating
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating
    );
  }
}
