import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

import 'drag_like_stack.dart';

class DragSlideStatusControl {
  final VoidCallback onSlideStarted;

  final VoidCallback onSlideCompleted;

  final VoidCallback onSlideCanceled;

  final SlideChanged<double, SlideDirection> onSlide;

  final int itemCount;

  int currentIndex = 0;
  int belowIndex = 1;

  computerIndex() {
    if (currentIndex < itemCount - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
  }

  computerBelowIndex() {
    if (belowIndex < itemCount - 1) {
      belowIndex++;
    } else {
      belowIndex = 0;
    }
  }

  DragSlideStatusControl(this.onSlideStarted, this.onSlideCompleted,
      this.onSlideCanceled, this.onSlide, this.itemCount);
}

/// Container that can be slid.
///
/// Will automatically finish the slide animation when the drag gesture ends.
class SlideContainer extends StatefulWidget {
  final Widget Function(int index,bool isMask) itemBuilder;

  final double slideDistance;

  final double rotateRate;

  final Duration reShowDuration;

  final double minAutoSlideDragVelocity;

  final DragSlideStatusControl control;

  SlideContainer({
    Key key,
    @required this.control,
    @required this.itemBuilder,
    @required this.slideDistance,
    this.rotateRate = 0.25,
    this.minAutoSlideDragVelocity = 600.0,
    this.reShowDuration,
  })  : assert(itemBuilder != null),
        assert(rotateRate != null),
        assert(minAutoSlideDragVelocity != null),
        assert(reShowDuration != null),
        super(key: key);

  @override
  ContainerState createState() => ContainerState();
}

class ContainerState extends State<SlideContainer>
    with TickerProviderStateMixin {
  final Map<Type, GestureRecognizerFactory> gestures =
      <Type, GestureRecognizerFactory>{};

  RestartableTimer timer;

  // User's finger move value.
  double dragValue = 0.0;

  int stackIndex = 0;

  // How long should the container move.
  double dragTarget = 0.0;
  bool isFirstDragFrame;
  AnimationController animationController;
  Ticker fingerTicker;

  double get maxDragDistance => widget.slideDistance;

  double get minAutoSlideDistance => maxDragDistance * 0.5;

  // The translation offset of the container.(decides the position of the container)
  double get containerOffset =>
      animationController.value *
      maxDragDistance *
      (1.0 + widget.rotateRate) *
      dragTarget.sign;

  set containerOffset(double value) {
    containerOffset = value;
  }

  static final int completed = 1;
  static final int side = 2;
  static final int cancel = 3;
  int dragStatus = side;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.reShowDuration)
          ..addListener(() {
            widget.control.onSlide(animationController.value, slideDirection);
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed &&
                dragStatus == completed) {
              Future.delayed(Duration(milliseconds: 500), () {
                widget.control.computerBelowIndex();
                setState(() {});
              });
            }
          });

    fingerTicker = createTicker((_) {
      if ((dragValue - dragTarget).abs() <= 1.0) {
        dragTarget = dragValue;
      } else {
        dragTarget += (dragValue - dragTarget);
      }
      animationController.value = dragTarget.abs() / maxDragDistance;
    });

    _registerGestureRecognizer();

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    fingerTicker?.dispose();
    timer?.cancel();
    super.dispose();
  }

  GestureRecognizerFactoryWithHandlers<T>
      createGestureRecognizer<T extends DragGestureRecognizer>(
              GestureRecognizerFactoryConstructor<T> constructor) =>
          GestureRecognizerFactoryWithHandlers<T>(
            constructor,
            (T instance) {
              instance
                ..onStart = handleDragStart
                ..onUpdate = handleDragUpdate
                ..onEnd = handleDragEnd;
            },
          );

  void _registerGestureRecognizer() {
    gestures[HorizontalDragGestureRecognizer] =
        createGestureRecognizer<HorizontalDragGestureRecognizer>(
            () => HorizontalDragGestureRecognizer());
  }

  double getVelocity(DragEndDetails details) =>
      details.velocity.pixelsPerSecond.dx;

  double getDelta(DragUpdateDetails details) => details.delta.dx;

  void reShow() {
    setState(() {
      animationController.value = 0.0;
    });
  }

  void _startTimer() {
    if (timer == null) {
      timer = RestartableTimer(widget.reShowDuration, reShow);
    } else {
      timer.reset();
    }
  }

  void _completeSlide() {
    dragStatus = completed;
    widget.control.computerIndex();
    animationController.forward().then((_) {
      widget.control.onSlideCompleted();
      _startTimer();
    });
  }

  void _cancelSlide() {
    dragStatus = cancel;
    animationController.reverse().then((_) {
      widget.control.onSlideCanceled();
    });
  }

  void handleDragStart(DragStartDetails details) {
    dragStatus = side;
    isFirstDragFrame = true;
    dragValue = animationController.value * maxDragDistance * dragTarget.sign;
    dragTarget = dragValue;
    fingerTicker.start();
    widget.control.onSlideStarted();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    if (isFirstDragFrame) {
      isFirstDragFrame = false;
      return;
    }
    dragValue = (dragValue + getDelta(details))
        .clamp(-maxDragDistance, maxDragDistance);

    if (slideDirection == SlideDirection.left) {
      dragValue = dragValue.clamp(-maxDragDistance, 0.0);
    } else if (slideDirection == SlideDirection.right) {
      dragValue = dragValue.clamp(0.0, maxDragDistance);
    }
  }

  void handleDragEnd(DragEndDetails details) {
    if (getVelocity(details) * dragTarget.sign >
        widget.minAutoSlideDragVelocity) {
      _completeSlide();
    } else if (getVelocity(details) * dragTarget.sign <
        -widget.minAutoSlideDragVelocity) {
      _cancelSlide();
    } else {
      dragTarget.abs() > minAutoSlideDistance
          ? _completeSlide()
          : _cancelSlide();
    }
    fingerTicker.stop();
  }

  SlideDirection get slideDirection =>
      dragValue.isNegative ? SlideDirection.left : SlideDirection.right;

  double get rotation => animationController.value * widget.rotateRate;

  Matrix4 get transformMatrix => slideDirection == SlideDirection.left
      ? (Matrix4.rotationZ(rotation)..invertRotation())
      : (Matrix4.rotationZ(rotation));

  Widget _getContainer() {
    return Transform(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: widget.itemBuilder(widget.control.currentIndex,false),
      ),
      transform: transformMatrix,
      alignment: FractionalOffset.center,
    );
  }

  @override
  Widget build(BuildContext context) => RawGestureDetector(
        gestures: gestures,
        child: Transform.translate(
          offset: Offset(
            containerOffset,
            0.0,
          ),
          child: _getContainer(),
        ),
      );
}
