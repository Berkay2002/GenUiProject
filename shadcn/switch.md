# Switch


A control that allows the user to toggle between checked and not checked.

```dart
class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return ShadSwitch(
      value: value,
      onChanged: (v) => setState(() => value = v),
      label: const Text('Airplane Mode'),
    );
  }
}
```

## Form

```dart
ShadSwitchFormField(
  id: 'terms',
  initialValue: false,
  inputLabel:
      const Text('I accept the terms and conditions'),
  onChanged: (v) {},
  inputSublabel:
      const Text('You agree to our Terms and Conditions'),
  validator: (v) {
    if (!v) {
      return 'You must accept the terms and conditions';
    }
    return null;
  },
)
```