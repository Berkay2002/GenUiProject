import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/src/models/carousel_component.dart';

class GenCarousel extends StatelessWidget {
  final CarouselComponent component;

  const GenCarousel({
    super.key,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Carousel Component: ${component.id}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text('Config: ${component.config}'),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: component.data.length,
                itemBuilder: (context, index) {
                  final item = CarouselItem.fromJson(component.data[index]);
                  return SizedBox(
                    width: 200,
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(item.title),
                          Text(item.description),
                          // Image.network(item.imageUrl), // Will be implemented in Phase 3
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
