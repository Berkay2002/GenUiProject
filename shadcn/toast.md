# Toast


A succinct message that is displayed temporarily.

```dart
ShadButton.outline(
  child: const Text('Add to calendar'),
  onPressed: () {
    ShadToaster.of(context).show(
      ShadToast(
        title: const Text('Scheduled: Catch up'),
        description:
            const Text('Friday, February 10, 2023 at 5:57 PM'),
        action: ShadButton.outline(
          child: const Text('Undo'),
          onPressed: () => ShadToaster.of(context).hide(),
        ),
      ),
    );
  },
),
```

## Simple

```dart
ShadButton.outline(
  child: const Text('Show Toast'),
  onPressed: () {
    ShadToaster.of(context).show(
      const ShadToast(
        description: Text('Your message has been sent.'),
      ),
    );
  },
),
```

## With Title

```dart
ShadButton.outline(
  child: const Text('Show Toast'),
  onPressed: () {
    ShadToaster.of(context).show(
      const ShadToast(
        title: Text('Uh oh! Something went wrong'),
        description:
            Text('There was a problem with your request'),
      ),
    );
  },
),
```

## With Action

```dart
ShadButton.outline(
  child: const Text('Show Toast'),
  onPressed: () {
    ShadToaster.of(context).show(
      ShadToast(
        title: const Text('Uh oh! Something went wrong'),
        description:
            const Text('There was a problem with your request'),
        action: ShadButton.outline(
          child: const Text('Try again'),
          onPressed: () => ShadToaster.of(context).hide(),
        ),
      ),
    );
  },
),
```

## Destructive

```dart
final theme = ShadTheme.of(context);

ShadButton.outline(
  child: const Text('Show Toast'),
  onPressed: () {
    ShadToaster.of(context).show(
      ShadToast.destructive(
        title: const Text('Uh oh! Something went wrong'),
        description:
            const Text('There was a problem with your request'),
        action: ShadButton.destructive(
          child: const Text('Try again'),
          decoration: ShadDecoration(
            border: ShadBorder.all(
              color: theme.colorScheme.destructiveForeground,
              width: 1,
            ),
          ),
          onPressed: () => ShadToaster.of(context).hide(),
        ),
      ),
    );
  },
),
```