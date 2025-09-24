class UpdateProfileParam {
  final String id;
  String? name;
  String? email;
  String? number;

  UpdateProfileParam({required this.id, this.name, this.email, this.number});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
    };
  }
}