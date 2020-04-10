import 'package:flutter/cupertino.dart';

class PersonalCenterPage extends StatefulWidget {
  PersonalCenterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PersonalCenterPageState();
}

class PersonalCenterPageState extends State<PersonalCenterPage>
    with
        AutomaticKeepAliveClientMixin<PersonalCenterPage>,
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
