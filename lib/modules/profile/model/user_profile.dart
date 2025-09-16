class UserProfile {
  final String id;
  final String name;
  final String email;
  final String number;
  final String imageUrl;

  UserProfile(
     {
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.imageUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      number: json['number'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'number': number,
        'imageUrl': imageUrl,
      };
}
