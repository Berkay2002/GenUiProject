# Button


Displays a button or a component that looks like a button.

## Primary

```dart
ShadButton(
  child: const Text('Primary'),
  onPressed: () {},
)
```

## Secondary

```dart
ShadButton.secondary(
  child: const Text('Secondary'),
  onPressed: () {},
)
```

## Destructive

```dart
ShadButton.destructive(
  child: const Text('Destructive'),
  onPressed: () {},
)
```

## Outline

```dart
ShadButton.outline(
  child: const Text('Outline'),
  onPressed: () {},
)
```

## Ghost

```dart
ShadButton.ghost(
  child: const Text('Ghost'),
  onPressed: () {},
)
```

## Link

```dart
ShadButton.link(
  child: const Text('Link'),
  onPressed: () {},
)
```

## Text and Icon

```dart
ShadButton(
  onPressed: () {},
  leading: const Icon(LucideIcons.mail),
  child: const Text('Login with Email'),
)
```

## Loading

```dart
ShadButton(
  onPressed: () {},
  leading: SizedBox.square(
    dimension: 16,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: ShadTheme.of(context).colorScheme.primaryForeground,
    ),
  ),
  child: const Text('Please wait'),
)
```

## Gradient and Shadow

```dart
ShadButton(
  onPressed: () {},
  gradient: const LinearGradient(colors: [
    Colors.cyan,
    Colors.indigo,
  ]),
  shadows: [
    BoxShadow(
      color: Colors.blue.withOpacity(.4),
      spreadRadius: 4,
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ],
  child: const Text('Gradient with Shadow'),
)
```