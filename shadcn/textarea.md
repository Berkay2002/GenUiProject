# Textarea


Displays a form textarea or a component that looks like a textarea.

```dart
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 400),
  child: const ShadTextarea(
    placeholder: Text('Type your message here'),
  ),
),
```

## Form

```dart
ShadTextareaFormField(
  id: 'bio',
  label: const Text('Bio'),
  placeholder:
      const Text('Tell us a little bit about yourself'),
  description: const Text(
      'You can @mention other users and organizations.'),
  validator: (v) {
    if (v.length < 10) {
      return 'Bio must be at least 10 characters.';
    }
    return null;
  },
)
```