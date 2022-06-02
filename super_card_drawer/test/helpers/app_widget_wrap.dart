import 'package:flutter/material.dart';

class AppWidgetWrap extends StatelessWidget {
  final Widget child;
  const AppWidgetWrap({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      home: Scaffold(body: child),
      color: Colors.black,
    );
  }
}
