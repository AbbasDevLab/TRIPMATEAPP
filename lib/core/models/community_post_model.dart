import 'package:json_annotation/json_annotation.dart';

part 'community_post_model.g.dart';

@JsonSerializable()
class CommunityPostModel {
  final String id;
  final String userId;
  final String? content;
  final List<String> images;
  final Map<String, double>? location;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final UserPostInfo? user;

  CommunityPostModel({
    required this.id,
    required this.userId,
    this.content,
    this.images = const [],
    this.location,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.isLiked = false,
    required this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityPostModelToJson(this);
}

@JsonSerializable()
class UserPostInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String? profileImage;

  UserPostInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profileImage,
  });

  String get fullName => '$firstName $lastName';

  factory UserPostInfo.fromJson(Map<String, dynamic> json) =>
      _$UserPostInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserPostInfoToJson(this);
}

@JsonSerializable()
class PostCommentModel {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final UserPostInfo? user;

  PostCommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.user,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentModelToJson(this);
}

