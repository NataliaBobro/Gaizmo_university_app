import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

part 'chat.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ChatListItem {
  bool success;
  List<ChatItem> data;

  ChatListItem({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$ChatListItemToJson(this);

  factory ChatListItem.fromJson(Map<String, dynamic> json) => _$ChatListItemFromJson(json);
}


@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ChatItem {
  int? id;
  String? name;
  String? type;
  Messages? lastMessage;
  List<UserData>? recipients;

  ChatItem({
    this.id,
    this.name,
    this.type,
    this.lastMessage,
    this.recipients
  });

  Map<String, dynamic> toJson() => _$ChatItemToJson(this);

  factory ChatItem.fromJson(Map<String, dynamic> json) => _$ChatItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ListMessages {
  List<Messages>? data;

  ListMessages({
    this.data,
  });

  Map<String, dynamic> toJson() => _$ListMessagesToJson(this);

  factory ListMessages.fromJson(Map<String, dynamic> json) => _$ListMessagesFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Messages {
  int? id;
  int? userId;
  int? chatId;
  String? message;
  String? createdAt;
  List<MessageAttachment>? attachment;

  @JsonKey(includeFromJson: false)
  List<File>? attachmentFile;

  Messages({
    this.id,
    this.userId,
    this.message,
    this.attachment,
    this.createdAt,
    this.attachmentFile,
  });

  Map<String, dynamic> toJson() => _$MessagesToJson(this);

  factory Messages.fromJson(Map<String, dynamic> json) => _$MessagesFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class MessageAttachment {
  int? id;
  String? patch;

  MessageAttachment({
    this.id,
    this.patch,
  });

  Map<String, dynamic> toJson() => _$MessageAttachmentToJson(this);

  factory MessageAttachment.fromJson(Map<String, dynamic> json) => _$MessageAttachmentFromJson(json);
}