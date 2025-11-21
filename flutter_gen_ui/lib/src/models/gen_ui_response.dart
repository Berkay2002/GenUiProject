import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen_ui/src/models/gen_component.dart';

part 'gen_ui_response.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class GenUiResponse {
  final GenComponent component;

  const GenUiResponse({
    required this.component,
  });

  factory GenUiResponse.fromJson(Map<String, dynamic> json) =>
      _$GenUiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenUiResponseToJson(this);
}
