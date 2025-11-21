import 'package:flutter/foundation.dart';
import 'package:flutter_gen_ui/flutter_gen_ui.dart';

enum MessageType {
  text,
  ui,
}

@immutable
class ChatMessage {
  final String id;
  final String? text;
  final GenComponent? uiComponent;
  final bool isUserMessage;
  final MessageType type;

  const ChatMessage({
    required this.id,
    this.text,
    this.uiComponent,
    required this.isUserMessage,
    required this.type,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    GenComponent? uiComponent,
    bool? isUserMessage,
    MessageType? type,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      uiComponent: uiComponent ?? this.uiComponent,
      isUserMessage: isUserMessage ?? this.isUserMessage,
      type: type ?? this.type,
    );
  }
}
