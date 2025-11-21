# InputOTP


Accessible one-time password component with copy paste functionality.

```dart
ShadInputOTP(
  onChanged: (v) => print('OTP: $v'),
  maxLength: 6,
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(size: 24, LucideIcons.dot),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)
```

## InputFormatters

Using InputFormatters you can restrict the input characters.
The example below shows how to restrict the input to only numbers.

```dart
ShadInputOTP(
  onChanged: (v) => print('OTP: $v'),
  maxLength: 4,
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)
```

See also `UpperCaseTextInputFormatter` and `LowerCaseTextInputFormatter` which are provided by the package.

## Form

```dart
ShadInputOTPFormField(
  id: 'otp',
  maxLength: 6,
  label: const Text('OTP'),
  description: const Text('Enter your OTP.'),
  validator: (v) {
    if (v.contains(' ')) {
      return 'Fill the whole OTP code';
    }
    return null;
  },
  children: const [
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
    Icon(size: 24, LucideIcons.dot),
    ShadInputOTPGroup(
      children: [
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
        ShadInputOTPSlot(),
      ],
    ),
  ],
)
```