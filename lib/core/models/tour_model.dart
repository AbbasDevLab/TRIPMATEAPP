import 'package:json_annotation/json_annotation.dart';

part 'tour_model.g.dart';

@JsonSerializable()
class TourModel {
  final String id;
  final String guideId;
  final String title;
  final String description;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int maxParticipants;
  final int currentParticipants;
  final double price;
  final List<String> images;
  final double? rating;
  final int? reviewCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TourModel({
    required this.id,
    required this.guideId,
    required this.title,
    required this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.maxParticipants,
    this.currentParticipants = 0,
    required this.price,
    this.images = const [],
    this.rating,
    this.reviewCount = 0,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isAvailable =>
      isActive && currentParticipants < maxParticipants && startDate.isAfter(DateTime.now());

  factory TourModel.fromJson(Map<String, dynamic> json) =>
      _$TourModelFromJson(json);

  Map<String, dynamic> toJson() => _$TourModelToJson(this);
}

