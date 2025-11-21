# Time Picker


A time picker component.

```dart
class PrimaryTimePicker extends StatelessWidget {
  const PrimaryTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: const ShadTimePicker(
        trailing: Padding(
          padding: EdgeInsets.only(left: 8, top: 14),
          child: Icon(LucideIcons.clock4),
        ),
      ),
    );
  }
}
```

## Form

```dart
ShadTimePickerFormField(
  label: const Text('Pick a time'),
  onChanged: print,
  description:
      const Text('The time of the day you want to pick'),
  validator: (v) => v == null ? 'A time is required' : null,
)
```

## ShadTimePickerFormField.period

```dart
ShadTimePickerFormField.period(
  label: const Text('Pick a time'),
  onChanged: print,
  description:
      const Text('The time of the day you want to pick'),
  validator: (v) => v == null ? 'A time is required' : null,
),
```