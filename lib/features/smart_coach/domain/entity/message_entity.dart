import 'package:fitness/core/enum/sender.dart';

class MessageEntity {

  final Sender role;
  final String text;
  final DateTime? timestamp;
  final DateTime? editedAt;
  final bool isDeleted;

  const MessageEntity({

    required this.role,
    required this.text,
    this.timestamp,
    this.editedAt,
    this.isDeleted = false,
  });

  MessageEntity copyWith({

    Sender? role,
    String? text,
    DateTime? timestamp,
    DateTime? editedAt,
    bool? isDeleted,
  }) {
    return MessageEntity(
      role: role ?? this.role,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      editedAt: editedAt ?? this.editedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}