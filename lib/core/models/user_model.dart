import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String? phone;
  final String firstName;
  final String lastName;
  final String? profileImage;
  final String? bio;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isVerified;
  final bool is2FAEnabled;
  final String? fccuId;
  final Map<String, dynamic>? preferences;

  UserModel({
    required this.id,
    required this.email,
    this.phone,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    this.bio,
    required this.createdAt,
    this.updatedAt,
    this.isVerified = false,
    this.is2FAEnabled = false,
    this.fccuId,
    this.preferences,
  });

  String get fullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

