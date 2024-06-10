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
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatItemToJson(ChatItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'recipients': instance.recipients,
      'messages': instance.messages,
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
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'message': instance.message,
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
