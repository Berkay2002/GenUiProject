import 'package:flutter/foundation.dart';
import 'package:flutter_gen_ui/src/models/carousel_component.dart';
import 'package:flutter_gen_ui/src/models/timeline_component.dart';
import 'package:flutter_gen_ui/src/models/gen_component_type.dart';

@immutable
abstract class GenComponent {
  final GenComponentType type;
  final String id;
  final Map<String, dynamic>? config;
  final List<Map<String, dynamic>> data;

  const GenComponent({
    required this.type,
    required this.id,
    this.config,
    required this.data,
  });

  factory GenComponent.fromJson(Map<String, dynamic> json) {
    final type =
        GenComponentType.values.byName(json['type'] ?? GenComponentType.unknown.name);
    
    switch (type) {
      case GenComponentType.carousel:
        return CarouselComponent.fromJson(json);
      case GenComponentType.timeline:
        return TimelineComponent.fromJson(json);
      case GenComponentType.unknown:
        throw ArgumentError('Unknown GenComponentType: ${json['type']}');
    }
  }

  Map<String, dynamic> toJson();
}

/// Abstract class for a single item in a GenComponent's data list.
@immutable
abstract class GenComponentItem {
  const GenComponentItem();

  Map<String, dynamic> toJson();
}

