import 'package:json_annotation/json_annotation.dart';

part 'trip_model.g.dart';

enum TripCategory {
  @JsonValue('adventure')
  adventure,
  @JsonValue('cultural')
  cultural,
  @JsonValue('religious')
  religious,
  @JsonValue('educational')
  educational,
  @JsonValue('leisure')
  leisure,
  @JsonValue('business')
  business,
  @JsonValue('photography')
  photography,
  @JsonValue('food_dining')
  foodDining,
}

enum TripType {
  @JsonValue('solo')
  solo,
  @JsonValue('group')
  group,
  @JsonValue('family')
  family,
  @JsonValue('business')
  business,
  @JsonValue('educational')
  educational,
  @JsonValue('religious')
  religious,
}

@JsonSerializable()
class TripModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final TripCategory category;
  final TripType type;
  final DateTime startDate;
  final DateTime endDate;
  final String destination;
  final double? budget;
  final Map<String, dynamic>? itinerary;
  final Map<String, dynamic>? accommodations;
  final Map<String, dynamic>? transportation;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  TripModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.category,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.destination,
    this.budget,
    this.itinerary,
    this.accommodations,
    this.transportation,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}

