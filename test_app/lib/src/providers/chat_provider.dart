import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/flutter_gen_ui.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:test_app/src/models/chat_message.dart';
import 'package:uuid/uuid.dart';

enum ChatStatus { idle, loading }

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  ChatStatus _status = ChatStatus.idle;
  ChatStatus get status => _status;

  late final GenerativeModel _model;

  ChatProvider() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3-pro-preview',
    );
  }

  final String _systemInstruction = """
    You are a UI Generation Engine. You do not answer with text. You answer ONLY with JSON.
    If the user asks for a comparison, generate a 'carousel'.
    If the user asks for a process/history, generate a 'timeline'.
    Use this schema: {"component": {"type": "carousel|timeline", "id": "unique_id", "config": {"theme": "dark|light", "speed": 1.0}, "data": [{"id": "item_id", "title": "", "description": "", "imageUrl": ""}]} } """;

  Future<void> sendMessage(String text) async {
    _messages.add(
      ChatMessage(
        id: const Uuid().v4(),
        text: text,
        isUserMessage: true,
        type: MessageType.text,
      ),
    );
    _status = ChatStatus.loading;
    notifyListeners();

    try {
      final content = [Content.text(_systemInstruction + text)];
      final response = await _model.generateContent(content);
      _handleResponse(response);
    } catch (e) {
      _messages.add(
        ChatMessage(
          id: const Uuid().v4(),
          text: "Error: $e",
          isUserMessage: false,
          type: MessageType.text,
        ),
      );
      _status = ChatStatus.idle;
      notifyListeners();
    }
  }

  void _handleResponse(GenerateContentResponse response) {
    final text = response.text;
    if (text == null) {
      _messages.add(
        ChatMessage(
          id: const Uuid().v4(),
          text: "Error: Empty response from AI",
          isUserMessage: false,
          type: MessageType.text,
        ),
      );
      _status = ChatStatus.idle;
      notifyListeners();
      return;
    }

    try {
      final uiComponent = GenUiParser.parse(text);
      _messages.add(
        ChatMessage(
          id: const Uuid().v4(),
          uiComponent: uiComponent,
          isUserMessage: false,
          type: MessageType.ui,
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          id: const Uuid().v4(),
          text: "Kunde inte rendera UI. Fel: $e",
          isUserMessage: false,
          type: MessageType.text,
        ),
      );
    }
    _status = ChatStatus.idle;
    notifyListeners();
  }
}
