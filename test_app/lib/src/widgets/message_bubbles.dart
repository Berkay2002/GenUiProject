import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/flutter_gen_ui.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:test_app/src/models/chat_message.dart';

class UserMessageBubble extends StatelessWidget {
  final String text;

  const UserMessageBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(4),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                text,
                style: theme.textTheme.p.copyWith(
                  color: theme.colorScheme.primaryForeground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AiMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const AiMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: message.type == MessageType.text
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.muted,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      message.text!,
                      style: theme.textTheme.p.copyWith(
                        color: theme.colorScheme.foreground,
                      ),
                    ),
                  )
                : message.uiComponent != null
                ? GenUiRenderer(component: message.uiComponent!)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
