import 'package:flutter/material.dart';

class MaterialWidgetWrap extends StatelessWidget {
  final Widget child;

  const MaterialWidgetWrap({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: child));
  }
}
