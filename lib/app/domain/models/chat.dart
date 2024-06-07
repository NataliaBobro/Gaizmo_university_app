import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

part 'chat.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ChatItem {
  int? id;
  String? name;
  List<UserData>? recipients;
  List<Messages>? messages;

  ChatItem({
    this.id,
    this.name,
    this.recipients,
    this.messages,
  });

  Map<String, dynamic> toJson() => _$ChatItemToJson(this);

  factory ChatItem.fromJson(Map<String, dynamic> json) => _$ChatItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Messages {
  int? id;
  String? text;
  List<MessageAttachment>? attachment;

  @JsonKey(includeFromJson: false)
  List<File>? attachmentFile;

  Messages({
    this.id,
    this.text,
    this.attachment,
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