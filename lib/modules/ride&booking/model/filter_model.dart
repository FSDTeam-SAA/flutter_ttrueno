

import 'package:flutter/foundation.dart';

class FilterModel {
  final int departureFlexMinutes;
  final double arrivalFlexKm;
  final double departureFlexKm;

  FilterModel({
    required this.arrivalFlexKm,
    required this.departureFlexKm,
    required this.departureFlexMinutes,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    try {
      return FilterModel(
        arrivalFlexKm: json["arrivalFlexKm"] as double,
        departureFlexKm: json["departureFlexKm"] as double,
        departureFlexMinutes: json["departureFlexMinutes"] as int,
      );
    } catch (e) {
      debugPrint("FilterModel.fromJson error: $e, json: $json");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "arrivalFlexKm": arrivalFlexKm,
      "departureFlexKm": departureFlexKm,
      "departureFlexMinutes": departureFlexMinutes,
    };
  }
}
