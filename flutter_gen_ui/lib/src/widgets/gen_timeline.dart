import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen_ui/src/models/timeline_component.dart';

class GenTimeline extends StatefulWidget {
  final TimelineComponent component;

  const GenTimeline({super.key, required this.component});

  @override
  State<GenTimeline> createState() => _GenTimelineState();
}

class _GenTimelineState extends State<GenTimeline> {
  late List<TimelineItem> _items;
  int _currentStep = 0;
  late List<GlobalKey> _itemKeys;

  @override
  void initState() {
    super.initState();
    _items = widget.component.items;
    _itemKeys = List.generate(_items.length, (_) => GlobalKey());
  }

  void _markStepCompleted(int index) {
    setState(() {
      if (index < _items.length - 1) {
        _currentStep = index + 1;
        // Scroll to the next item after the state has been updated.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final context = _itemKeys[index + 1].currentContext;
          if (context != null) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        });
      }
      _items[index] = _items[index].copyWith(isCompleted: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Timeline configuration constants
    const double circleSize = 40.0;
    const double lineWidth = 2.0;
    const double topPadding = 20.0;

    // Calculate centered position for the line
    final double lineLeftPosition = (circleSize - lineWidth) / 2;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final isEnabled = index <= _currentStep;
        final isCompleted = item.isCompleted;

        return Opacity(
          key: _itemKeys[index],
          opacity: isEnabled ? 1.0 : 0.4,
          child: IgnorePointer(
            // Disable interaction for inactive steps
            ignoring: !isEnabled,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Timeline indicator column with continuous line
                  SizedBox(
                    width: circleSize,
                    child: Stack(
                      children: [
                        // Continuous vertical line extending from circle to bottom
                        if (index < _items.length - 1)
                          Positioned(
                            left: lineLeftPosition,
                            top: topPadding + circleSize,
                            bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              width: lineWidth,
                              color: isCompleted
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey.shade700,
                            ),
                          ),
                        // Top connecting line from previous item
                        if (index > 0)
                          Positioned(
                            left: lineLeftPosition,
                            top: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              width: lineWidth,
                              height: topPadding,
                              color: _items[index - 1].isCompleted
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey.shade700,
                            ),
                          ), // Circle avatar
                        Positioned(
                          top: topPadding,
                          left: 0,
                          child: Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted
                                  ? Theme.of(context).colorScheme.primary
                                  : isEnabled
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : Colors.grey.shade800,
                              border: Border.all(
                                color: isEnabled
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade700,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors
                                          .black, // Changed from white to black
                                      size: 20,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color:
                                            isCompleted // If completed, make text black
                                            ? Colors.black
                                            : isEnabled
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.onPrimaryContainer
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content card
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 8.0,
                        top: topPadding,
                        bottom: topPadding,
                      ),
                      child: Card(
                        elevation: isEnabled ? 2 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                item.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              if (isEnabled && !isCompleted)
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () => _markStepCompleted(index),
                                    child: const Text('Done'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
