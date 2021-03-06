import 'package:card_reveal_drawer/card_reveal_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'src/material_test_wrap.dart';

void main() {
  group('CardExpandDrawer', () {
    testWidgets('component renders', (WidgetTester tester) async {
      final cardWidget = MaterialWidgetWrap(
        child: CardRevealDrawer(
          dragVelocity: .3,
          size: const Size(
            300,
            300,
          ),
          drawerSize: 80,
          card: const Text('hello'),
          drawer: const Text('heloo'),
          direction: Direction.bottomToTop,
          onDrawerClosed: () => print('closed'),
          onDrawerOpened: () => print('opened'),
        ),
      );
      await tester.pumpWidget(cardWidget);

      final widgetContainer = find.byWidget(cardWidget);

      expect(widgetContainer, findsOneWidget);
    });
  });
}
