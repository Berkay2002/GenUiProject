# Resizable


Resizable panel groups and layouts.

```dart
class BasicResizable extends StatelessWidget {
  const BasicResizable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: theme.radius,
          border: Border.all(
            color: theme.colorScheme.border,
          ),
        ),
        child: ClipRRect(
          borderRadius: theme.radius,
          child: ShadResizablePanelGroup(
            children: [
              ShadResizablePanel(
                id: 0,
                defaultSize: .5,
                minSize: .2,
                maxSize: .8,
                child: Center(
                  child: Text('One', style: theme.textTheme.large),
                ),
              ),
              ShadResizablePanel(
                id: 1,
                defaultSize: .5,
                child: ShadResizablePanelGroup(
                  axis: Axis.vertical,
                  children: [
                    ShadResizablePanel(
                      id: 0,
                      defaultSize: .3,
                      child: Center(
                          child: Text('Two', style: theme.textTheme.large)),
                    ),
                    ShadResizablePanel(
                      id: 1,
                      defaultSize: .7,
                      child: Align(
                          child: Text('Three', style: theme.textTheme.large)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

:::tip
Try resizing a panel, then double-click on the handle to reset to the default size.
:::

## Vertical

Use the `axis` property to change the direction of the resizable panels.

```dart
class VerticalResizable extends StatelessWidget {
  const VerticalResizable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: theme.radius,
          border: Border.all(
            color: theme.colorScheme.border,
          ),
        ),
        child: ClipRRect(
          borderRadius: theme.radius,
          child: ShadResizablePanelGroup(
            axis: Axis.vertical,
            children: [
              ShadResizablePanel(
                id: 0,
                defaultSize: 0.3,
                minSize: 0.1,
                child: Center(
                  child: Text('Header', style: theme.textTheme.large),
                ),
              ),
              ShadResizablePanel(
                id: 1,
                defaultSize: 0.7,
                minSize: 0.1,
                child: Center(
                  child: Text('Footer', style: theme.textTheme.large),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Handle

You can show the handle by using the `showHandle` property.

You can customize it using the `handleIcon` or `handleIconSrc` properties.

```dart
class HandleResizable extends StatelessWidget {
  const HandleResizable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: theme.radius,
            border: Border.all(
              color: theme.colorScheme.border,
            ),
          ),
          child: ClipRRect(
          borderRadius: theme.radius,
          child: ShadResizablePanelGroup(
            showHandle: true,
            children: [
              ShadResizablePanel(
                id: 0,
                defaultSize: .5,
                minSize: .2,
                child: Center(
                  child: Text('Sidebar', style: theme.textTheme.large),
                ),
              ),
              ShadResizablePanel(
                id: 1,
                defaultSize: .5,
                minSize: .2,
                child: Center(
                  child: Text('Content', style: theme.textTheme.large),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```