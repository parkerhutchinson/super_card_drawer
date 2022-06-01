### Getting started

```dart
CardRevealDrawer(
  backgroundColor: Colors.blueGrey,
  dragVelocity: 20,
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
### Properties

---

| Property | Type |
| :-- | :-- |
| backgroundColor | Color? | 

Set background of container that holds the two cards. mostly used to debug the margins created when using CardExpandDrawer.

---

| Property | Type |
| :-- | :-- |
| card | Widget | 

Top most widget that covers the drawer. 

---

| Property | Type |
| :-- | :-- |
| direction | Direction | 

Governs the direction the top card moves to reveal the drawer. defaults to *leftToRight*. Possible values are `leftToRight` `rightToLeft` `topToBottom` `bottomToTOp`

---

| Property | Type |
| :-- | :-- |
| drawer | Widget | 

drawer widget that sits underneath the card widget. this widget and card are entirely up to the user to implement. so if the drawer reveals UI that is interactive its up to you to set the proper alignment.

---

| Property | Type |
| :-- | :-- |
| drawerSize | double | 

Sets the width or height the drawer reveals. With CardExpandDrawer this also affects how much margin there is. 

Unfortunetly Flutters current renderer prevents Positioned widgets from being interactive if they bleed the container. 
See this issue https://github.com/flutter/flutter/issues/19445 for more details. so the gutters are added to the two positioned elements to allow the expanded version to be interactive. If this is undesirable use CardRevealDrawer instead.  


---

| Property | Type |
| :-- | :-- |
| dragVelocity | double | 

Determines how easy the swipe is to reveal the drawer. Measured in pixels per-second, defaults to 15. Increase the amount to make it hard to open or decrease the amount to make it easier.

---

| Property | Type |
| :-- | :-- |
| onDrawerClosed | Function? | 

Function callback for when the drawer is closed.

---

| Property | Type |
| :-- | :-- |
| onDrawerDrag | Function(double value)? | 

Function callback for when the drawer is dragged. returns pixels the drawer has been dragged. Note: this doesn't currently represent when the drawer animates open or animates closed. Only the dragged value is returned.

---

| Property | Type |
| :-- | :-- |
| onDrawerOpened | Function? | 

Function callback for when the drawer is opened.

---

| Property | Type |
| :-- | :-- |
| onDrawerTap | Function? | 

Function callback for when the drawer is tapped. This only applies to drawers that you want to treat as a giant button instead of a container for other interactive elements. Requirees `tapDrawerClose: true` to be set.  

---

| Property | Type |
| :-- | :-- |
| size | Size |

Sets the size of the card and drawer to fill the container to make this effect work properly. 

---

| Property | Type |
| :-- | :-- |
| tapDrawerClose | bool |

Optional property to make it so the drawer closes on tap. this only really works if there are no interactive elements in the drawer itself. 

---

### Additional information

This is a for fun UI package so if issues arise or breaking changes occur no garauntees that it will get fixed in a timely manor. see license about warranty or maintenace. 
