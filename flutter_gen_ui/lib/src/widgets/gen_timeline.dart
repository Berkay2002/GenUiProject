import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen_ui/src/models/timeline_component.dart';

class GenTimeline extends StatefulWidget {
  final TimelineComponent component;

  const GenTimeline({
    super.key,
    required this.component,
  });

  @override
  State<GenTimeline> createState() => _GenTimelineState();
}

class _GenTimelineState extends State<GenTimeline> {
  late List<TimelineItem> _items;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _items = widget.component.items;
  }

  void _markStepCompleted(int index) {
    setState(() {
      if (index < _items.length - 1) {
        _currentStep = index + 1;
      }
      _items[index] = _items[index].copyWith(isCompleted: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final isEnabled = index <= _currentStep;
        final isCompleted = item.isCompleted;

        return Animate(
          effects: [
            if (isEnabled) FadeEffect(duration: 500.ms, delay: (index * 100).ms) else const Effect(duration: Duration.zero),
            if (isEnabled) SlideEffect(begin: const Offset(0.1, 0), duration: 500.ms, delay: (index * 100).ms) else const Effect(duration: Duration.zero),
          ],
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.4,
            child: IgnorePointer( // Disable interaction for inactive steps
              ignoring: !isEnabled,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomPaint(
                        painter: TimelinePainter(
                          isCompleted: isCompleted,
                          isLast: index == _items.length - 1,
                          accentColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 60,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: isCompleted
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TimelinePainter extends CustomPainter {
  final bool isCompleted;
  final bool isLast;
  final Color accentColor;

  TimelinePainter({
    required this.isCompleted,
    required this.isLast,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isCompleted ? accentColor : Colors.grey
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final circleRadius = 15.0;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw vertical line
    if (!isLast) {
      canvas.drawLine(
        Offset(center.dx, center.dy + circleRadius),
        Offset(center.dx, size.height),
        paint,
      );
    }

    // Draw circle
    canvas.drawCircle(center, circleRadius, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant TimelinePainter oldDelegate) {
    return oldDelegate.isCompleted != isCompleted ||
           oldDelegate.isLast != isLast ||
           oldDelegate.accentColor != accentColor;
  }
}