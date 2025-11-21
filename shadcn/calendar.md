# Calendar


A date field component that allows users to enter and edit date.

```dart
class SingleCalendar extends StatefulWidget {
  const SingleCalendar({super.key});

  @override
  State<SingleCalendar> createState() => _SingleCalendarState();
}

class _SingleCalendarState extends State<SingleCalendar> {
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(
      selected: today,
      fromMonth: DateTime(today.year - 1),
      toMonth: DateTime(today.year, 12),
    );
  }
}
```

## Multiple

```dart
class MultipleCalendar extends StatefulWidget {
 const MultipleCalendar({super.key});

 @override
 State<MultipleCalendar> createState() => _MultipleCalendarState();
}

class _MultipleCalendarState extends State<MultipleCalendar> {
 final today = DateTime.now();

 @override
 Widget build(BuildContext context) {
   return ShadCalendar.multiple(
     numberOfMonths: 2,
     fromMonth: DateTime(today.year),
     toMonth: DateTime(today.year + 1, 12),
     min: 5,
     max: 10,
   );
 }
}
```

## Range

```dart
class RangeCalendar extends StatelessWidget {
 const RangeCalendar({super.key});

 @override
 Widget build(BuildContext context) {
   return const ShadCalendar.range(
     min: 2,
     max: 5,
   );
 }
}
```

#### DropdownMonths

```dart
ShadCalendar(
  captionLayout: ShadCalendarCaptionLayout.dropdownMonths,
);
```

#### DropdownYears

```dart
ShadCalendar(
  captionLayout: ShadCalendarCaptionLayout.dropdownYears,
);
```

### Hide Navigation

```dart
ShadCalendar(
  hideNavigation: true,
);
```

### Show Week Numbers

```dart
ShadCalendar(
  showWeekNumbers: true,
);
```

### Show Outside Days (false)

```dart
ShadCalendar(
  showOutsideDays: false,
);
```

### Fixed Weeks

```dart
ShadCalendar(
  fixedWeeks: true,
);
```

### Hide Weekday Names

```dart
ShadCalendar(
  hideWeekdayNames: true,
);
```