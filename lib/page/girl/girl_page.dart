import 'package:flutter/cupertino.dart';

class GirlPage extends StatefulWidget {
  GirlPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GirlPageState();
}

class GirlPageState extends State<GirlPage>
    with
        AutomaticKeepAliveClientMixin<GirlPage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
