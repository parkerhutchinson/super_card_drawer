import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:card_reveal_drawer/card_reveal_drawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromRGBO(174, 192, 219, 1),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(174, 192, 219, 1),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Builder(builder: (context) {
              return Column(
                children: [
                  CardRevealDrawer(
                    dragVelocity: 20,
                    size: Size(
                      MediaQuery.of(context).size.width - 20,
                      300,
                    ),
                    drawerSize: 80,
                    card: const TopCard(),
                    drawer: const Drawer(),
                    direction: Direction.bottomToTop,
                    onDrawerClosed: () => print('closed'),
                    onDrawerOpened: () => print('opened'),
                  ),
                  CardRevealDrawer(
                    dragVelocity: 20,
                    size: Size(
                      MediaQuery.of(context).size.width - 20,
                      300,
                    ),
                    drawerSize: 80,
                    card: const TopCard(),
                    drawer: const Drawer(),
                    direction: Direction.leftToRight,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  const TopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(219, 174, 174, 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black, width: 8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [Text('testing')],
            ),
            Row(
              children: [
                Container(
                    child: const CircleAvatar(
                  radius: 20,
                )),
                Container(
                    child: const CircleAvatar(
                  radius: 20,
                ))
              ],
            )
          ],
        ));
  }
}

class Drawer extends StatelessWidget {
  const Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const IconButton(assetPath: 'assets/icons/heart.svg'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const IconButton(assetPath: 'assets/icons/star.svg'),
          ),
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final String assetPath;
  const IconButton({
    required this.assetPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(48, 48, 48, 1),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => {},
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(assetPath),
        ),
      ),
    );
  }
}
