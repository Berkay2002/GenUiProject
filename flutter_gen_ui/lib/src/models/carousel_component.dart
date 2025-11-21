import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen_ui/src/models/gen_component.dart';
import 'package:flutter_gen_ui/src/models/gen_component_type.dart';

part 'carousel_component.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class CarouselComponent extends GenComponent {
  final List<CarouselItem> items;

  CarouselComponent({
    required super.id,
    super.config,
    required super.data,
  })  : items = data.map((e) => CarouselItem.fromJson(e)).toList(),
        super(type: GenComponentType.carousel);

  factory CarouselComponent.fromJson(Map<String, dynamic> json) =>
      _$CarouselComponentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CarouselComponentToJson(this);
}

@JsonSerializable()
@immutable
class CarouselItem extends GenComponentItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  const CarouselItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) =>
      _$CarouselItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CarouselItemToJson(this);
}
