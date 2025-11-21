# Tooltip


A popup that displays information related to an element when the element receives keyboard focus or the mouse hovers over it.

```dart
ShadTooltip(
  builder: (context) => const Text('Add to library'),
  child: ShadButton.outline(
    child: const Text('Hover/Focus'),
    onPressed: () {},
  ),
),
```

:::caution
The tooltip works on hover only if the child uses a `ShadGestureDetector`. If you don't use a `ShadButton` or something similar that implements `ShadGestureDetector` hover will not work.
If, for example, you want to just show an image as child, wrap it with `ShadGestureDetector` to make it working.
:::