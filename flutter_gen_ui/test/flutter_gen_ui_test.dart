import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen_ui/src/index.dart';

void main() {
  group('GenUiParser', () {
    test('parses a valid carousel JSON', () {
      const rawJson = '''
        {
          "component": {
            "type": "carousel",
            "id": "test_carousel",
            "config": {"theme": "dark"},
            "data": [
              {
                "id": "item1",
                "title": "Item 1",
                "description": "Description 1",
                "imageUrl": "https://example.com/image1.png"
              },
              {
                "id": "item2",
                "title": "Item 2",
                "description": "Description 2",
                "imageUrl": "https://example.com/image2.png"
              }
            ]
          }
        }
      ''';
      
      final component = GenUiParser.parse(rawJson);
      
      expect(component, isA<CarouselComponent>());
      expect(component.type, GenComponentType.carousel);
      expect(component.id, "test_carousel");
      expect(component.config!['theme'], "dark");
      expect(component.data.length, 2);
      expect(CarouselItem.fromJson(component.data[0]).title, "Item 1");
    });

    test('parses a valid timeline JSON', () {
      const rawJson = '''
        {
          "component": {
            "type": "timeline",
            "id": "test_timeline",
            "config": {"theme": "light"},
            "data": [
              {
                "id": "step1",
                "title": "Step 1",
                "description": "Description for step 1",
                "isCompleted": false
              },
              {
                "id": "step2",
                "title": "Step 2",
                "description": "Description for step 2",
                "isCompleted": false
              }
            ]
          }
        }
      ''';

      final component = GenUiParser.parse(rawJson);

      expect(component, isA<TimelineComponent>());
      expect(component.type, GenComponentType.timeline);
      expect(component.id, "test_timeline");
      expect(component.config!['theme'], "light");
      expect(component.data.length, 2);
      expect(TimelineItem.fromJson(component.data[0]).id, "step1");
      expect(TimelineItem.fromJson(component.data[0]).title, "Step 1");
      expect(TimelineItem.fromJson(component.data[0]).isCompleted, false);
    });

    test('throws FormatException for invalid JSON', () {
      const rawJson = '{"type": "carousel", "id": "123", "data": [}'; // Invalid JSON
      expect(() => GenUiParser.parse(rawJson), throwsA(isA<FormatException>()));
    });

    test('throws FormatException for unknown component type', () {
      const rawJson = '''
        {
          "component": {
            "type": "unsupported_type",
            "id": "test_id",
            "data": []
          }
        }
      ''';
      expect(() => GenUiParser.parse(rawJson), throwsA(isA<FormatException>()));
    });
  });
}
