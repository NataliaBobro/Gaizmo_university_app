// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListItem _$ChatListItemFromJson(Map<String, dynamic> json) => ChatListItem(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatListItemToJson(ChatListItem instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

ChatItem _$ChatItemFromJson(Map<String, dynamic> json) => ChatItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      lastMessage: json['last_message'] == null
          ? null
          : Messages.fromJson(json['last_message'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatItemToJson(ChatItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'last_message': instance.lastMessage,
      'recipients': instance.recipients,
    };

ListMessages _$ListMessagesFromJson(Map<String, dynamic> json) => ListMessages(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListMessagesToJson(ListMessages instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      message: json['message'] as String?,
      attachment: (json['attachment'] as List<dynamic>?)
          ?.map((e) => MessageAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'message': instance.message,
      'created_at': instance.createdAt,
      'attachment': instance.attachment,
    };

MessageAttachment _$MessageAttachmentFromJson(Map<String, dynamic> json) =>
    MessageAttachment(
      id: json['id'] as int?,
      patch: json['patch'] as String?,
    );

Map<String, dynamic> _$MessageAttachmentToJson(MessageAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patch': instance.patch,
    };
