# RadioGroup


A set of checkable buttons—known as radio buttons—where no more than one of the buttons can be checked at a time.

```dart
ShadRadioGroup<String>(
  items: [
    ShadRadio(
      label: Text('Default'),
      value: 'default',
    ),
    ShadRadio(
      label: Text('Comfortable'),
      value: 'comfortable',
    ),
    ShadRadio(
      label: Text('Nothing'),
      value: 'nothing',
    ),
  ],
),
```

## Form

```dart
enum NotifyAbout {
  all,
  mentions,
  nothing;

  String get message {
    return switch (this) {
      all => 'All new messages',
      mentions => 'Direct messages and mentions',
      nothing => 'Nothing',
    };
  }
}

ShadRadioGroupFormField<NotifyAbout>(
  label: const Text('Notify me about'),
  items: NotifyAbout.values.map(
    (e) => ShadRadio(
      value: e,
      label: Text(e.message),
    ),
  ),
  validator: (v) {
    if (v == null) {
      return 'You need to select a notification type.';
    }
    return null;
  },
),
```