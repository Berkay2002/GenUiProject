import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/src/models/carousel_component.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GenCarousel extends StatefulWidget {
  final CarouselComponent component;

  const GenCarousel({super.key, required this.component});

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

  void _showDetailDialog(BuildContext context, CarouselItem item) {
    final theme = ShadTheme.of(context);
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: Text(item.title),
        description: const Text('Full details'),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                      placeholder: (context, url) => const SizedBox(
                        height: 250,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 250,
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 64),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(item.description, style: theme.textTheme.p),
              ],
            ),
          ),
        ),
        actions: [
          ShadButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Increased from 300 to show more content
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
              child: GestureDetector(
                onTap: () => _showDetailDialog(context, item),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Hero(
                          tag: '${widget.component.id}-${item.id}',
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[800],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 48,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Image unavailable',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Expanded(
                                    child: Text(
                                      item.description,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tap for details',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Colors.grey[600],
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
