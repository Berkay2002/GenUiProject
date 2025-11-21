// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselComponent _$CarouselComponentFromJson(Map<String, dynamic> json) =>
    CarouselComponent(
      id: json['id'] as String,
      config: json['config'] as Map<String, dynamic>?,
      data: (json['data'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$CarouselComponentToJson(CarouselComponent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'config': instance.config,
      'data': instance.data,
    };

CarouselItem _$CarouselItemFromJson(Map<String, dynamic> json) => CarouselItem(
  title: json['title'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$CarouselItemToJson(CarouselItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
