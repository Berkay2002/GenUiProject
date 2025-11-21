import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/src/models/gen_component.dart';
import 'package:flutter_gen_ui/src/models/gen_component_type.dart';
import 'package:flutter_gen_ui/src/widgets/gen_carousel.dart';
import 'package:flutter_gen_ui/src/widgets/gen_timeline.dart';
import 'package:flutter_gen_ui/src/models/carousel_component.dart';
import 'package:flutter_gen_ui/src/models/timeline_component.dart';

class GenUiRenderer extends StatelessWidget {
  final GenComponent component;

  const GenUiRenderer({
    super.key,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    try {
      switch (component.type) {
        case GenComponentType.carousel:
          return GenCarousel(component: component as CarouselComponent);
        case GenComponentType.timeline:
          return GenTimeline(component: component as TimelineComponent);
        case GenComponentType.unknown:
          return ErrorWidget(
              'Unsupported UI Type generated: ${component.type.name}');
      }
    } catch (e) {
      return ErrorWidget('Error rendering UI: $e');
    }
  }
}
