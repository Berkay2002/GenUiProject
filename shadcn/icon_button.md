# IconButton


Displays an icon button or a component that looks like a button with an icon.

## Primary

```dart
ShadIconButton(
  onPressed: () => print('Primary'),
  icon: const Icon(LucideIcons.rocket),
)
```

## Secondary

```dart
ShadIconButton.secondary(
  icon: const Icon(LucideIcons.rocket),
  onPressed: () => print('Secondary'),
)
```

## Destructive

```dart
ShadIconButton.destructive(
  icon: const Icon(LucideIcons.rocket),
  onPressed: () => print('Destructive'),
)
```

## Outline

```dart
ShadIconButton.outline(
  icon: const Icon(LucideIcons.rocket),
  onPressed: () => print('Outline'),
)
```

## Ghost

```dart
ShadIconButton.ghost(
  icon: const Icon(LucideIcons.rocket),
  onPressed: () => print('Ghost'),
)
```

## Loading

```dart
ShadIconButton(
  icon: SizedBox.square(
    dimension: 16,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: ShadTheme.of(context).colorScheme.primaryForeground,
    ),
  ),
)
```

## Gradient and Shadow

```dart
ShadIconButton(
  gradient: const LinearGradient(colors: [
    Colors.cyan,
    Colors.indigo,
  ]),
  shadows: [
    BoxShadow(
      color: Colors.blue.withValues(alpha: .4),
      spreadRadius: 4,
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ],
  icon: const Icon(LucideIcons.rocket),
)
```