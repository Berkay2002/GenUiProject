import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen_ui/src/models/gen_component.dart';
import 'package:flutter_gen_ui/src/models/gen_component_type.dart';

part 'carousel_component.g.dart';

@JsonSerializable()
@immutable
class CarouselComponent extends GenComponent {
  const CarouselComponent({
    required super.id,
    super.config,
    required super.data,
  }) : super(type: GenComponentType.carousel);

  factory CarouselComponent.fromJson(Map<String, dynamic> json) =>
      _$CarouselComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CarouselComponentToJson(this);
}

@JsonSerializable()
@immutable
class CarouselItem extends GenComponentItem {
  final String title;
  final String description;
  final String imageUrl;

  const CarouselItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) =>
      _$CarouselItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CarouselItemToJson(this);
}
