import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';

class ArticleListItem extends StatelessWidget {
  final ArticleModel model;

  const ArticleListItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _card(context, model);
  }

  testModel() => ArticleModel(
      "5e87aed831ec89ebfc601f04",
      "underwindfall",
      "GanHuo",
      "2020-04-04 05:47:04",
      "使用 ViewPager2 实现无限轮播效果，可以用来实现 banner 以及上下滚动文字广告等。",
      ["https://gank.io/images/dff02e8101f34494a58876f05d88bfd9"],
      0,
      "2020-04-04 21:28:15",
      1,
      "CycleViewPager2 - 使用 ViewPager2 实现无限轮播效果，可以用来实现 banner",
      "Android",
      "https://github.com/wangpeiyuan/CycleViewPager2",
      89);

  _card(BuildContext context, ArticleModel model) {
    return Container(
        height: 220.w,
        padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
        child: Material(
            color: Colors.transparent,
            child: Card(
                elevation: 1,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                      margin: EdgeInsets.all(10.w),
                      child: _content(context, model)),
                ))));
  }

  _content(BuildContext context, ArticleModel model) => Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _imageItem(context, model),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 2.w),
                        color: ThemeColors.label,
                        child: Text(model.type,
                            style: TextStyle(color: ThemeColors.white))),
                    Padding(padding: EdgeInsets.only(left: 15.w)),
                    Expanded(
                        child: Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display2,
                    ))
                  ]),
              Padding(padding: EdgeInsets.only(top: 5.w)),
              Expanded(
                  child: Text(
                model.desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.display3,
              )),
              Container(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.network(
                      GankIcons.HOME_AUTHOR_LABEL_ICON_URL,
                      width: 25.w,
                      height: 25.w,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Text(model.author,
                            style: Theme.of(context).textTheme.subhead)),
                    Text("—", style: TextStyle(color: ThemeColors.label)),
                    Padding(padding: EdgeInsets.only(right: 10.w)),
                    Expanded(
                      child: Text(model.type,
                          style: Theme.of(context).textTheme.display3),
                    ),
                    Text(
                        "${CommonUtils.getNewsTimeStr(DateTime.parse(model.createdAt))}更新",
                        style: Theme.of(context).textTheme.subhead)
                  ],
                ),
              )
            ],
          ))
        ],
      );

  _imageItem(BuildContext context, ArticleModel model) {
    if (model.images != null && model.images.length > 0) {
      return Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: Image.network(
            model.images[0],
            width: 240.w,
            height: 220.w,
          ));
    } else {
      return Container();
    }
  }
}
