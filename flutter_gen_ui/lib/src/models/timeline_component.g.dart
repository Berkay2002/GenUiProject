// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineComponent _$TimelineComponentFromJson(Map<String, dynamic> json) =>
    TimelineComponent(
      id: json['id'] as String,
      config: json['config'] as Map<String, dynamic>?,
      data: (json['data'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$TimelineComponentToJson(TimelineComponent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'config': instance.config,
      'data': instance.data,
    };

TimelineItem _$TimelineItemFromJson(Map<String, dynamic> json) => TimelineItem(
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$TimelineItemToJson(TimelineItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };
