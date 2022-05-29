import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Direction {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

class CardExpandDrawer extends HookWidget {
  /// Applies a background to the card container, mostly used to debug gutters.
  final Color? backgroundColor;

  /// Top Card Widget
  final Widget card;

  /// enum of drawer open directions defaults to `leftToRight`
  /// possible values are `leftToRight, rightToLeft, topToBottom, bottomToTop`
  final Direction direction;

  /// drawer Widget
  final Widget drawer;

  /// How large should the drawer size be.
  ///
  /// NOTE: this will make the gutter between other widgets
  /// increase. The increase is deterministic, its exactly
  /// half the drawer size(on either side). this has to do with the issue
  /// above with GestureDetector.
  final double drawerSize;

  /// pixels per second, determines how easy the drawer is to open.
  final double dragVelocity;

  /// callback when the drawer is closed
  final Function? onDrawerClosed;

  /// callback when the drawer is opened
  final Function? onDrawerOpened;

  /// callback when the drawer is tapped
  final Function? onDrawerTap;

  /// Size is required for the workaround for GestureDetector.
  /// GestureDetectors hitbox gets cut off when positioned
  /// elements bleed the container. https://github.com/flutter/flutter/issues/19445

  /// Im using matrix transforms to animate the cards moving outward.
  /// this causes a bleed to happen on the parent container and
  /// prevents taps from being detected outside the container.
  /// This leads to bad UX where you'd expect anything visibile
  /// to be interactive.
  final Size size;

  /// Alt interaction that removes the swipe to close with tapping the drawer to close.
  final bool? tapDrawerClose;

  /// example:
  /// ```
  /// CardExpandDrawer(
  ///   backgroundColor: Colors.red,
  ///   dragThreshold: .3,
  ///   size: Size(400, 300),
  ///   drawerSize: 200,
  ///   direction: Direction.topToBottom,
  ///   topCard: Container(
  ///     padding: const EdgeInsets.all(20),
  ///     decoration: const BoxDecoration(
  ///       color = Colors.blueGrey,
  ///         borderRadius = const BorderRadius.all(Radius.circular(30)),
  ///       ),
  ///       child: const Text(
  ///         'hello world',
  ///       style = const TextStyle(
  ///         color: Colors.white,
  ///       ),
  ///     ),
  ///   ),
  ///   bottomCard: Container(
  ///     padding = const EdgeInsets.all(20),
  ///     decoration = const BoxDecoration(
  ///     color: Colors.black,
  ///     borderRadius: BorderRadius.all(Radius.circular(30)),
  ///   ),
  ///   child = const Text(
  ///     'hahah yes',
  ///       style: TextStyle(
  ///         color: Colors.white,
  ///       ),
  ///     ),
  ///   ),
  /// ),
  /// ```
  const CardExpandDrawer({
    required this.size,
    required this.drawerSize,
    required this.drawer,
    required this.card,
    this.dragVelocity = 15,
    this.backgroundColor,
    this.onDrawerTap,
    this.onDrawerClosed,
    this.onDrawerOpened,
    this.tapDrawerClose = false,
    this.direction = Direction.leftToRight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<double> dragState = useState<double>(0);
    ValueNotifier<bool> isDragging = useState(false);
    ValueNotifier<bool> open = useState(false);

    bool isVertical =
        direction.name == 'bottomToTop' || direction.name == 'topToBottom';
    return Container(
      color: backgroundColor,
      width: size.width,
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: isVertical ? 0 : drawerSize / 2,
            top: isVertical ? drawerSize / 2 : 0,
            height: isVertical ? size.height - drawerSize : size.height,
            width: !isVertical ? size.width - drawerSize : size.width,
            child: _CardSlideAnimation(
              isDrawer: true,
              isDragging: isDragging,
              dragState: dragState,
              direction: direction,
              child: GestureDetector(
                onTap: () {
                  if (onDrawerTap != null) {
                    onDrawerTap!();
                  }

                  if (tapDrawerClose!) {
                    open.value = false;
                    dragState.value = 0;
                  }
                },
                child: drawer,
              ),
            ),
          ),
          Positioned(
            left: isVertical ? 0 : drawerSize / 2,
            top: isVertical ? drawerSize / 2 : 0,
            height: isVertical ? size.height - drawerSize : size.height,
            width: !isVertical ? size.width - drawerSize : size.width,
            child: IgnorePointer(
              ignoring: open.value && tapDrawerClose!,
              child: GestureDetector(
                onPanStart: (details) {
                  isDragging.value = true;
                },
                onPanUpdate: (details) {
                  // set drag bounds
                  dragState.value += _swipeBounds(
                    direction: direction,
                    delta: details.delta,
                    currentOffset: dragState.value,
                    drawerSize: drawerSize,
                  );
                },
                onPanEnd: (details) {
                  isDragging.value = false;
                  double detailsVelocity = isVertical
                      ? details.velocity.pixelsPerSecond.dy
                      : details.velocity.pixelsPerSecond.dx;
                  // bool isThresholdMet =

                  if (direction.name == 'leftToRight' ||
                      direction.name == 'bottomToTop') {
                    dragState.value = detailsVelocity > 15 ? drawerSize : 0;
                    open.value = detailsVelocity > 15 ? true : false;
                    if (detailsVelocity > dragVelocity) {
                      if (onDrawerOpened != null) {
                        onDrawerOpened!();
                      }
                    } else {
                      if (onDrawerClosed != null) {
                        onDrawerClosed!();
                      }
                    }
                  }

                  if (direction.name == 'rightToLeft' ||
                      direction.name == 'topToBottom') {
                    dragState.value =
                        detailsVelocity < dragVelocity ? -drawerSize : 0;
                    open.value = detailsVelocity < dragVelocity ? true : false;
                    if (detailsVelocity < dragVelocity) {
                      if (onDrawerOpened != null) {
                        onDrawerOpened!();
                      }
                    } else {
                      if (onDrawerClosed != null) {
                        onDrawerClosed!();
                      }
                    }
                  }
                },
                child: _CardSlideAnimation(
                  isDrawer: false,
                  isDragging: isDragging,
                  dragState: dragState,
                  direction: direction,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: card,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardSlideAnimation extends StatelessWidget {
  final ValueNotifier<bool> isDragging;
  final ValueNotifier<double> dragState;
  final Widget child;
  final bool isDrawer;
  final Direction direction;

  const _CardSlideAnimation({
    super.key,
    required this.isDragging,
    required this.dragState,
    required this.child,
    required this.isDrawer,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    final int transitionDuration = isDragging.value ? 0 : 200;
    return AnimatedContainer(
      curve: Curves.ease,
      duration: Duration(milliseconds: transitionDuration),
      transform: _swipeMatrix(
        direction: direction,
        drag: dragState.value,
        isDrawer: isDrawer,
      ),
      child: child,
    );
  }
}

Matrix4 _swipeMatrix({
  required double drag,
  required Direction direction,
  required bool isDrawer,
}) {
  Matrix4 swipeMatrix;

  if (direction.name == 'topToBottom' || direction.name == 'bottomToTop') {
    swipeMatrix = Matrix4.identity()
      ..translate(0.0, isDrawer ? -drag / 2 : drag / 2, 0.0);
  } else {
    swipeMatrix = Matrix4.identity()
      ..translate(isDrawer ? -drag / 2 : drag / 2, 0.0, 0.0);
  }

  return swipeMatrix;
}

double _swipeBounds({
  required Direction direction,
  required Offset delta,
  required double currentOffset,
  required double drawerSize,
}) {
  double dragValue = 0;
  double deltaOrientationValue =
      direction.name == 'bottomToTop' || direction.name == 'topToBottom'
          ? delta.dy
          : delta.dx;

  if (direction.name == 'leftToRight' || direction.name == 'bottomToTop') {
    if (currentOffset >= 0 && currentOffset <= drawerSize) {
      dragValue += deltaOrientationValue;
    }
  }

  if (direction.name == 'rightToLeft' || direction.name == 'topToBottom') {
    if (currentOffset <= 0 && currentOffset >= (drawerSize * -1)) {
      dragValue += deltaOrientationValue;
    }
  }

  // wow that is some crazy syntax lol.
  return dragValue;
}
