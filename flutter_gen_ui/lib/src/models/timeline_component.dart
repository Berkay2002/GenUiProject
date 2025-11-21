import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen_ui/src/models/gen_component.dart';
import 'package:flutter_gen_ui/src/models/gen_component_type.dart';

part 'timeline_component.g.dart';

@JsonSerializable()
@immutable
class TimelineComponent extends GenComponent {
  const TimelineComponent({
    required super.id,
    super.config,
    required super.data,
  }) : super(type: GenComponentType.timeline);

  factory TimelineComponent.fromJson(Map<String, dynamic> json) =>
      _$TimelineComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimelineComponentToJson(this);
}

@JsonSerializable()
@immutable
class TimelineItem extends GenComponentItem {
  final String title;
  final String description;

  const TimelineItem({
    required this.title,
    required this.description,
  });

  factory TimelineItem.fromJson(Map<String, dynamic> json) =>
      _$TimelineItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimelineItemToJson(this);
}
