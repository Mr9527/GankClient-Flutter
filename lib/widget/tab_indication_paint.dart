import 'dart:math' as math;
import 'package:flutter/material.dart';

class TabIndicatorPainter extends CustomPainter {
  final PageController pageController;
  final double dxEntry;
  final double dxTarget;
  final double radius;
  final double dy;
  Paint painter;
  TabIndicatorPainter(
      {this.dxEntry = 25.0,
        this.dxTarget = 125.0,
        this.dy = 25.0,
        this.radius = 21.0,
        this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final index = pageController.position;
    double fullExtent = (index.maxScrollExtent -
        index.minScrollExtent +
        index.viewportDimension);

    double pageOffest = index.extentBefore / fullExtent;

    bool leftToRight = dxEntry < dxTarget;
    Offset entry = Offset(leftToRight ? dxEntry : dxTarget, dy);
    Offset target = Offset(leftToRight ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(new Rect.fromCircle(center: entry, radius: radius),
        0.5 * math.pi, 1 * math.pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(new Rect.fromCircle(center: target, radius: radius),
        1.5 * math.pi, 1 * math.pi);
    canvas.translate(size.width * pageOffest, 0.0);
    canvas.drawShadow(path,Color(0xFFfbb66) , 3.0, true);
//    canvas.drawShadow(path, Color(0xFFfbb66), 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicatorPainter oldDelegate) => true;
}