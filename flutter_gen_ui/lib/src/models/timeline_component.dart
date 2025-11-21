import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen_ui/src/models/gen_component.dart';
import 'package:flutter_gen_ui/src/models/gen_component_type.dart';

part 'timeline_component.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class TimelineComponent extends GenComponent {
  final List<TimelineItem> items;

  TimelineComponent({
    required super.id,
    super.config,
    required super.data,
  })  : items = data.map((e) => TimelineItem.fromJson(e)).toList(),
        super(type: GenComponentType.timeline);

  factory TimelineComponent.fromJson(Map<String, dynamic> json) =>
      _$TimelineComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimelineComponentToJson(this);
}

@JsonSerializable()
@immutable
class TimelineItem extends GenComponentItem {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TimelineItem({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false, // Default to false
  });

  factory TimelineItem.fromJson(Map<String, dynamic> json) =>
      _$TimelineItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimelineItemToJson(this);

  TimelineItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TimelineItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
