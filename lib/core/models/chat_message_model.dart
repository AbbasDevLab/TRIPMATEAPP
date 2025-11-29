import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('location')
  location,
  @JsonValue('sos')
  sos,
}

@JsonSerializable()
class ChatMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String? receiverId;
  final String content;
  final MessageType type;
  final Map<String, dynamic>? metadata;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.receiverId,
    required this.content,
    required this.type,
    this.metadata,
    this.isRead = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

@JsonSerializable()
class ChatModel {
  final String id;
  final String? name;
  final List<String> participantIds;
  final String? lastMessageId;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isGroup;
  final String? imageUrl;

  ChatModel({
    required this.id,
    this.name,
    required this.participantIds,
    this.lastMessageId,
    this.lastMessageAt,
    required this.createdAt,
    this.updatedAt,
    this.isGroup = false,
    this.imageUrl,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

