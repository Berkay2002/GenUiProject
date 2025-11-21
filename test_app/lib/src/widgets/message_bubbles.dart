import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/flutter_gen_ui.dart';
import 'package:test_app/src/models/chat_message.dart';

class UserMessageBubble extends StatelessWidget {
  final String text;

  const UserMessageBubble({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AiMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const AiMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        padding: message.type == MessageType.text
            ? const EdgeInsets.all(12.0)
            : EdgeInsets.zero, // No padding for UI components, they handle their own
        decoration: BoxDecoration(
          color: message.type == MessageType.text ? Colors.grey[300] : Colors.transparent,
          borderRadius: message.type == MessageType.text
              ? BorderRadius.circular(12.0)
              : BorderRadius.zero,
        ),
        child: message.type == MessageType.text
            ? Text(
                message.text!,
                style: const TextStyle(color: Colors.black),
              )
            : message.uiComponent != null
                ? GenUiRenderer(component: message.uiComponent!)
                : const SizedBox.shrink(),
      ),
    );
  }
}
