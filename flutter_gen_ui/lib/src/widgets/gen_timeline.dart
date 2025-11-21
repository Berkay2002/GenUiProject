import 'package:flutter/material.dart';
import 'package:flutter_gen_ui/src/models/timeline_component.dart';

class GenTimeline extends StatelessWidget {
  final TimelineComponent component;

  const GenTimeline({
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
              'Timeline Component: ${component.id}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text('Config: ${component.config}'),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: component.data.length,
                itemBuilder: (context, index) {
                  final item = TimelineItem.fromJson(component.data[index]);
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item.title),
                    subtitle: Text(item.description),
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
