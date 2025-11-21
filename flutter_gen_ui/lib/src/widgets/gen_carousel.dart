import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/src/models/carousel_component.dart';

class GenCarousel extends StatefulWidget {
  final CarouselComponent component;

  const GenCarousel({
    super.key,
    required this.component,
  });

  @override
  State<GenCarousel> createState() => _GenCarouselState();
}

class _GenCarouselState extends State<GenCarousel> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.component.items.length,
        itemBuilder: (context, index) {
          final item = widget.component.items[index];
          final opacity = max(0.4, 1.0 - (_currentPage - index).abs() * 0.5);
          final scale = max(0.8, 1.0 - (_currentPage - index).abs() * 0.2);

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Hero(
                        tag: '${widget.component.id}-${item.id}', // Unique tag for Hero animation
                        child: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              item.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}