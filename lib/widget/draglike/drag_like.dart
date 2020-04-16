import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/model/girl_element_model.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:gankclient/page/girl/girl_detail_page.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'drag_like_stack.dart';

class DragLikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DragLikeState();
}

class DragLikeState extends State<DragLikePage> with TickerProviderStateMixin {
  GirlDragLikeBloc bloc = new GirlDragLikeBloc();

  SlideDirection slideDirection;

  void onSlide(double position, SlideDirection direction) {
    setState(() {
      this.slideDirection = direction;
    });
  }

  void onSlideCompleted() {
    bloc.slideCompleted();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.obtainList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('妹纸'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.refresh,
                color: Theme.of(context).cardTheme.color,
              ))
        ],
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
        StreamBuilder<List<GirlElementModel>>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (snapshot != null && snapshot.data != null) {
                var list = snapshot.data;
                return SlideStack(
                  itemCount: list.length,
                  itemBuilder: (index, isMask) {
                    return _renderCard(list[index], isMask);
                  },
                  slideDistance: MediaQuery.of(context).size.width - 40.0,
                  onSlide: onSlide,
                  onSlideCompleted: onSlideCompleted,
                  rotateRate: 0.4,
                );
              } else {
                return Container();
              }
            })
      ],
    );
  }

  Widget _renderCard(GirlElementModel girl, bool isMask) {
    var card = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: SizedBox.expand(
            child:
                isMask ? image(girl) : Hero(tag: girl.url, child: image(girl)),
          ),
        )),
        Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              girl.desc,
              maxLines: 2,
              style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 5,
                  color: Theme.of(context).textTheme.display2.color,
                  fontSize: 14),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )),
      ],
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (ctx) => GirlDetailPage(girl: girl)));
      },
      child: card,
    );
  }

  Image image(GirlElementModel girl) {
    return Image(
        image: ExtendedNetworkImageProvider(girl.url), fit: BoxFit.fill);
  }
}

class GirlDragLikeBloc {
  BehaviorSubject<List<GirlElementModel>> _subject =
      BehaviorSubject<List<GirlElementModel>>();

  Stream<List<GirlElementModel>> get stream => _subject;

  obtainList({int page = 1}) async {
    var res =
        await httpManager.fetch(API.categoryList("Girl", "Girl", page, 10), {});
    if (res != null && res.success) {
      _subject.add(getGirlElementModelList(res.data));
    }
  }

  void slideCompleted() {}
}
