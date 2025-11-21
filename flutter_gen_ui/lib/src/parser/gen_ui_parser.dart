import 'dart:convert';
import 'package:flutter_gen_ui/src/models/gen_component.dart';
import 'package:flutter_gen_ui/src/models/gen_ui_response.dart';

class GenUiParser {
  static GenComponent parse(String rawJson) {
    try {
      // Clean the raw JSON string by removing common LLM markdown code blocks
      String cleanedJson = rawJson.replaceFirst('```json', '');
      cleanedJson = cleanedJson.replaceFirst('```', '');
      cleanedJson = cleanedJson.trim();

      final Map<String, dynamic> jsonMap = json.decode(cleanedJson);
      return GenUiResponse.fromJson(jsonMap).component;
    } catch (e) {
      throw FormatException('Failed to parse GenUI JSON: $e');
    }
  }
}
