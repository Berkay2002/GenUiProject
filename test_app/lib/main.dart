import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:test_app/src/providers/chat_provider.dart';
import 'package:test_app/src/widgets/message_bubbles.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const GenChatApp());
}

class GenChatApp extends StatelessWidget {
  const GenChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: ShadApp.custom(
        themeMode: ThemeMode.dark,
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(),
        ),
        appBuilder: (context) {
          return MaterialApp(
            title: 'GenChat',
            theme: Theme.of(context),
            home: const ChatScreen(),
            builder: (context, child) {
              return ShadAppBuilder(child: child!);
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _hasText = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      Provider.of<ChatProvider>(
        context,
        listen: false,
      ).sendMessage(_textController.text);
      _textController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'GenChat',
          style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: theme.colorScheme.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                // Scroll to the bottom whenever messages change
                _scrollToBottom();
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messages[index];
                    if (message.isUserMessage) {
                      return UserMessageBubble(text: message.text!);
                    } else {
                      return AiMessageBubble(message: message);
                    }
                  },
                );
              },
            ),
          ),
          if (Provider.of<ChatProvider>(context).status == ChatStatus.loading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  Text("Thinking...", style: theme.textTheme.muted),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
            decoration: BoxDecoration(color: theme.colorScheme.background),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ShadButton.outline(
                  onPressed: () {
                    // TODO: Implement attachment functionality
                  },
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.zero,
                  decoration: const ShadDecoration(shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    color: theme.colorScheme.foreground,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadInput(
                    controller: _textController,
                    placeholder: const Text('Ask anything'),
                    minLines: 1,
                    maxLines: 5,
                    onSubmitted: (text) => _sendMessage(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    trailing: _hasText
                        ? GestureDetector(
                            onTap: _sendMessage,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.send,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                            ),
                          )
                        : null,
                    decoration: ShadDecoration(
                      border: ShadBorder.all(
                        color: theme.colorScheme.border,
                        radius: BorderRadius.circular(30),
                      ),
                      focusedBorder: ShadBorder.all(
                        width: 1,
                        color: theme.colorScheme.border,
                        radius: BorderRadius.circular(30),
                      ),
                      secondaryBorder: ShadBorder.all(
                        width: 0,
                        color: Colors.transparent,
                      ),
                      secondaryFocusedBorder: ShadBorder.all(
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
