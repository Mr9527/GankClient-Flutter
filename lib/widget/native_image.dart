import 'package:flutter/cupertino.dart';

class NativeImage extends StatelessWidget {
  final String imageName;
  final double width;
  final double height;

  const NativeImage(this.imageName, {Key key, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (width != 0 && height != 0) {
      return Image(
        image: AssetImage('static/images/$imageName.png'),
        fit: BoxFit.fill,
        width: this.width,
        height: this.height,
      );
    } else
      return Image(image: AssetImage('static/images/$imageName.png'));
  }
}
