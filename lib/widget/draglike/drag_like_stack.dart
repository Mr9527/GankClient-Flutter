import 'package:flutter/material.dart';

import 'drag_like_container.dart';

enum SlideDirection {
  left,
  right,
}

typedef SlideChanged<double, SlideDirection> = void Function(
    double value, SlideDirection value2);

class SlideStack extends StatefulWidget {
  final double slideDistance;

  final double rotateRate;
  final double scaleRate;

  final Duration scaleDuration;

  /// If the drag gesture is fast enough, it will auto complete the slide.
  final double minAutoSlideDragVelocity;

  /// Called when the drawer starts to open.
  final VoidCallback onSlideStarted;

  /// Called when the drawer is full opened.
  final VoidCallback onSlideCompleted;

  /// Called when the drag gesture is canceled (the container goes back to the starting position).
  final VoidCallback onSlideCanceled;

  final Widget Function(int index, bool isMask) itemBuilder;

  final int itemCount;

  /// Called each time when the slide gesture is active.
  ///
  /// returns the position of the drawer between 0.0 and 1.0 (depends on the progress of animation).
  ///
  final SlideChanged<double, SlideDirection> onSlide;

  const SlideStack({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.slideDistance,
    this.rotateRate = 0.25,
    this.scaleRate = 1.05,
    this.scaleDuration = const Duration(milliseconds: 250),
    this.minAutoSlideDragVelocity = 600.0,
    this.onSlideStarted,
    this.onSlideCompleted,
    this.onSlideCanceled,
    this.onSlide,
  })  : assert(itemBuilder != null),
        assert(minAutoSlideDragVelocity != null),
        assert(scaleDuration != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _StackState();
}

class _StackState extends State<SlideStack> with TickerProviderStateMixin {
  double position = 0.0;
  double elevation = 0.0;
  AnimationController controller;
  Animation<double> animation;
  DragSlideStatusControl dragSideController;

  @override
  void initState() {
    super.initState();
    dragSideController = DragSlideStatusControl(onSlideStarted, onCompleted,
        onSlideCanceled, onSlide, widget.itemCount);
    controller = new AnimationController(
      vsync: this,
      duration: widget.scaleDuration,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller
              .animateTo(0.0, duration: widget.scaleDuration)
              .whenCompleteOrCancel(() {
            elevation = 0.0;
            setState(() {});
          });
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSlide(value, direction) {
    if (widget.onSlide != null) widget.onSlide(value, direction);
    controller.value = value;
    setState(() {});
  }

  void onSlideStarted() {
    if (widget.onSlideStarted != null) widget.onSlideStarted();
    elevation = 1.0;
    setState(() {});
  }

  void onSlideCanceled() {
    if (widget.onSlideCanceled != null) widget.onSlideCanceled();
    elevation = 0.0;
    setState(() {});
  }

  void onCompleted() {}

  double get scale => 1 + controller.value * (widget.scaleRate - 1.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        mask(),
        Positioned.fill(
          child: SlideContainer(
            control: dragSideController,
            itemBuilder: widget.itemBuilder,
            slideDistance: widget.slideDistance,
            rotateRate: widget.rotateRate,
            minAutoSlideDragVelocity: widget.minAutoSlideDragVelocity,
            reShowDuration: widget.scaleDuration,
          ),
          left: 10.0,
          top: 20.0,
          bottom: 40.0,
          right: 10.0,
        ),
      ],
    );
  }

  Positioned mask() {
    return Positioned.fill(
        child: Transform.scale(
            scale: scale,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  left: 40.0,
                  top: 40.0,
                  bottom: 20.0,
                  right: 40.0,
                ),
                Positioned(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  left: 30.0,
                  top: 30.0,
                  bottom: 25.0,
                  right: 30.0,
                ),
                Positioned(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  left: 20.0,
                  top: 30.0,
                  bottom: 32.0,
                  right: 20.0,
                ),
                Positioned(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: elevation,
                    child: widget.itemBuilder(dragSideController.belowIndex,true),
                  ),
                  left: 10.0,
                  top: 20.0,
                  bottom: 40.0,
                  right: 10.0,
                )
              ],
            )));
  }
}
