import 'dart:async';
import 'dart:developer' as dev;

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
      generationConfig: GenerationConfig(temperature: 1.0),
      tools: [
        Tool.googleSearch(), // Enable Google Search grounding for real image URLs
      ],
    );
  }

  final String _systemInstruction = """
    You are a UI Generation Engine. You do not answer with text. You answer ONLY with JSON.
    If the user asks for a comparison, generate a 'carousel'.
    If the user asks for a process/history, generate a 'timeline'.
    
    IMPORTANT: Use Google Search to find REAL, valid image URLs for the items. Do not make up URLs.
    Provide complete, detailed descriptions (at least 2-3 sentences per item).
    
    Use this schema: {"component": {"type": "carousel|timeline", "id": "unique_id", "config": {"theme": "dark|light", "speed": 1.0}, "data": [{"id": "item_id", "title": "", "description": "", "imageUrl": ""}]} } """;

  Future<void> sendMessage(String text) async {
    dev.log('📤 Sending message to AI: "$text"', name: 'ChatProvider');

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

      dev.log(
        '🤖 Requesting AI response with Google Search enabled...',
        name: 'ChatProvider',
      );
      final startTime = DateTime.now();

      // Add timeout to detect slow responses (120 seconds for Gemini 3 Pro)
      final response = await _model
          .generateContent(content)
          .timeout(
            const Duration(seconds: 120),
            onTimeout: () {
              throw TimeoutException(
                'The AI is taking longer than expected to respond. Please try again.',
              );
            },
          );

      final duration = DateTime.now().difference(startTime);
      dev.log(
        '✅ AI response received in ${duration.inSeconds}s',
        name: 'ChatProvider',
      );

      // Log if Google Search was used
      if (response.candidates.isNotEmpty) {
        final candidate = response.candidates.first;
        if (candidate.groundingMetadata != null) {
          dev.log(
            '🔍 Google Search was used for grounding',
            name: 'ChatProvider',
          );
          dev.log(
            '   Search queries: ${candidate.groundingMetadata?.searchEntryPoint?.renderedContent ?? "N/A"}',
            name: 'ChatProvider',
          );
        }
      }

      _handleResponse(response);
    } catch (e) {
      dev.log('❌ Error: $e', name: 'ChatProvider', error: e);
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    String userMessage;

    // Check for specific error types and provide user-friendly messages
    if (error.toString().contains('SocketException') ||
        error.toString().contains('Connection timed out')) {
      userMessage =
          '🌐 Network Error\n\nCouldn\'t connect to the AI service. Please check your internet connection and try again.';
    } else if (error.toString().contains('TimeoutException')) {
      userMessage =
          '⏱️ Request Timeout\n\nThe AI took too long to respond. This might be due to:\n• Network issues\n• Server overload\n\nPlease try again in a moment.';
    } else if (error.toString().contains('API key')) {
      userMessage =
          '🔑 API Key Error\n\nThere\'s an issue with the API configuration. Please check your Firebase setup.';
    } else if (error.toString().contains('quota') ||
        error.toString().contains('rate limit')) {
      userMessage =
          '📊 Rate Limit Exceeded\n\nYou\'ve reached the API usage limit. Please try again later.';
    } else {
      userMessage =
          '❌ Something went wrong\n\n${error.toString()}\n\nPlease try again.';
    }

    _messages.add(
      ChatMessage(
        id: const Uuid().v4(),
        text: userMessage,
        isUserMessage: false,
        type: MessageType.text,
      ),
    );
    _status = ChatStatus.idle;
    notifyListeners();
  }

  void _handleResponse(GenerateContentResponse response) {
    final text = response.text;
    if (text == null) {
      dev.log('⚠️ Empty response from AI', name: 'ChatProvider');
      _handleError('No response from AI');
      return;
    }

    dev.log('📝 Raw AI response: $text', name: 'ChatProvider');

    try {
      dev.log('🔄 Parsing JSON to UI component...', name: 'ChatProvider');
      final uiComponent = GenUiParser.parse(text);

      dev.log(
        '✨ Successfully created ${uiComponent.type} component with ${uiComponent.data.length} items',
        name: 'ChatProvider',
      );

      _messages.add(
        ChatMessage(
          id: const Uuid().v4(),
          uiComponent: uiComponent,
          isUserMessage: false,
          type: MessageType.ui,
        ),
      );
    } catch (e) {
      dev.log(
        '❌ Failed to parse UI component: $e',
        name: 'ChatProvider',
        error: e,
      );
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
