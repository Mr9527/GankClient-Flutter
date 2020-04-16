import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/model/girl_element_model.dart';

class GirlDetailPage extends StatefulWidget {
  final GirlElementModel girl;

  const GirlDetailPage({Key key, this.girl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GirlDetailPageState();
}

class _GirlDetailPageState extends State<GirlDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Hero(
          tag: widget.girl.url,
          child: Image(
              image: ExtendedNetworkImageProvider(widget.girl.url),
              fit: BoxFit.fill)),
    ));
  }
}
