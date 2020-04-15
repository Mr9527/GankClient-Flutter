import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drag_like_stack.dart';

class Girl {
  final String description;
  final String asset;

  Girl(this.description, this.asset);
}

final List<Girl> girls = [
  Girl('Sliding to the left means dislike',
      'http://gank.io/images/8a9837115fb64d22b0484e3d4c4cab50'),
  Girl('slipping to the right means expressing love',
      'http://gank.io/images/8a9837115fb64d22b0484e3d4c4cab50'),
  Girl(
      'Hope you like', 'http://gank.io/images/8a9837115fb64d22b0484e3d4c4cab50')
];

class DragLikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DragLikeState();
}

class DragLikeState extends State<DragLikePage> with TickerProviderStateMixin {
  AnimationController controller;

  int aboveIndex = 0;
  int belowIndex = 1;

  final double bottomHeight = 100.0;
  final double defaultIconSize = 30.0;
  final Color defaultIconColor =
      Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), 0.0);

  double position = 0.0;
  SlideDirection slideDirection;

  double get leftIconSize => slideDirection == SlideDirection.left
      ? defaultIconSize * (1 + position * 0.8)
      : defaultIconSize;

  double get rightIconSize => slideDirection == SlideDirection.right
      ? defaultIconSize * (1 + position * 0.8)
      : defaultIconSize;

  Color get leftIconColor => slideDirection == SlideDirection.left
      ? Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), position)
      : defaultIconColor;

  Color get rightIconColor => slideDirection == SlideDirection.right
      ? Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), position)
      : defaultIconColor;

  void setAboveIndex() {
    if (aboveIndex < girls.length - 1) {
      aboveIndex++;
    } else {
      aboveIndex = 0;
    }
  }

  void setBelowIndex() {
    if (belowIndex < girls.length - 1) {
      belowIndex++;
    } else {
      belowIndex = 0;
    }
  }

  void onSlide(double position, SlideDirection direction) {
    setState(() {
      this.position = position;
      this.slideDirection = direction;
    });
  }

  void onSlideCompleted() {
    controller.forward();
    String isLike =
        (slideDirection == SlideDirection.left) ? 'dislike' : 'like';
    Fluttertoast.showToast(msg: "You $isLike this !");
    setAboveIndex();
  }

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    )
      ..addListener(() {
        setState(() {
          if (position != 0) {
            position = 1 - controller.value;
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag to choose like or dislike'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: _buildCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        Positioned(
          child: SlideStack(
            child: _buildChooseView(girls[aboveIndex]),
            below: _buildChooseView(girls[belowIndex]),
            slideDistance: MediaQuery.of(context).size.width - 40.0,
            onSlide: onSlide,
            onSlideCompleted: onSlideCompleted,
            refreshBelow: setBelowIndex,
            rotateRate: 0.4,
          ),
          left: 10.0,
          top: 20.0,
          bottom: 40.0,
          right: 10.0,
        ),
      ],
    );
  }

  Widget _buildChooseView(Girl girl) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
            child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Image.network(
                  girl.asset,
                  fit: BoxFit.fill,
                ))),
        Positioned(
          child: Text(
            girl.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
      ],
    );
  }

  Stack _buildBackground() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          left: 30.0,
          top: 30.0,
          bottom: 25.0,
          right: 30.0,
        ),
        Positioned(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          left: 20.0,
          top: 30.0,
          bottom: 32.0,
          right: 20.0,
        ),
      ],
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      height: bottomHeight,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Icon(
              Icons.favorite_border,
              size: leftIconSize,
              color: leftIconColor,
            )),
            Expanded(
                child: Icon(
              Icons.favorite,
              size: rightIconSize,
              color: rightIconColor,
            ))
          ],
        ),
      ),
    );
  }
}
