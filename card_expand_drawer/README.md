CardExpandDrawer is a UI widget that uses swipe gestures horizontally or vertically to reveal a drawer. The drawer can be functional or asthetic, the widgets for the drawer and the card are provide by you. This only handles the swipe to reveal functionality. This package differs from CardRevealDrawer in that it expands in both directions both the drawer and the top card animate in opposite directions. 

## Features

1. Vertical and Horizontal card layouts.
2. only the swipe gestures and directional movement are governed by this widget. all card and drawer widgets provided by the user. aka fully customizable widgets look and feel. 

## Getting started

```dart
CardExpandDrawer(
  backgroundColor: Colors.blueGrey,
  dragThreshold: .3,
  size: const Size(500, 400),
  drawerSize: 120,
  topCard: Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: const Text(
      'hahah yes',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  bottomCard: Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: const Text(
      'hello world',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
),
```
see /example for detailed examples.

## Additional information

This is a for fun UI package so if issues arise or breaking changes occur no garauntees that it will get fixed in a timely manor. 
