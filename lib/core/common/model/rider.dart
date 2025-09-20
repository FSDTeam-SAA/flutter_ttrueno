import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';

class Rider extends UserProfile {
  final BaggageType baggageType;
  Rider({
    required this.baggageType,
    required super.id,
    required super.name,
    required super.email,
    required super.number,
    required super.imageUrl,
    required super.rating,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      number: json['number'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      baggageType: BaggageType.fromString(json['baggageType']),
    );
  }

  @override
  bool operator ==(Object other) {
    return super == other &&
        baggageType.toString() == (other as Rider).baggageType.toString();
  }

  @override
  int get hashCode => baggageType.hashCode ^ super.hashCode;

  @override
  String toString() {
    return 'Rider(id: $id, name: $name, email: $email, number: $number, imageUrl: $imageUrl, rating: $rating, baggageType: ${baggageType.toString()})';
  }
}