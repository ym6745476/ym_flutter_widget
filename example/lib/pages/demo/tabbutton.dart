import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_tab_button.dart';

///Tab按钮
class TabButtonPage extends StatefulWidget {
  TabButtonPage({Key? key}) : super(key: key);

  final String title = "Tab Button";

  @override
  _TabButtonPageState createState() => _TabButtonPageState();
}

class _TabButtonPageState extends State<TabButtonPage> with SingleNativeStateMixin {
  List<String> _tabButtonList = ["全部", "待付款", "待发货"];
  int _tabButtonSelectedIndex = 0;

  @override
  void initState() {
    super.initState();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFlutter = arguments["flutter"];
        if (!Config.isNative || isRouteFlutter) {
          //加载数据
        }
      }
    });
  }

  Widget _getTabWidget(int index) {
    if (index == 0) {
      return Container(
        child: YmTabButton(
          _tabButtonList.elementAt(index),
          textColor: Color(0xffffffff),
          fontSize: 14,
          isSelected: this._tabButtonSelectedIndex == index,
          onClick: () => {tabButtonChange(index)},
          size: Size(90, 40),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(2)),
        ),
      );
    } else if (index == 1) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: YmTabButton(
          _tabButtonList.elementAt(index),
          textColor: Color(0xffffffff),
          fontSize: 14,
          isSelected: this._tabButtonSelectedIndex == index,
          onClick: () => {tabButtonChange(index)},
          size: Size(90, 40),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(2), right: Radius.circular(2)),
        ),
      );
    } else {
      return Container(
        child: YmTabButton(
          _tabButtonList.elementAt(index),
          textColor: Color(0xffffffff),
          fontSize: 14,
          isSelected: this._tabButtonSelectedIndex == index,
          onClick: () => {tabButtonChange(index)},
          size: Size(90, 40),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(2), right: Radius.circular(20)),
        ),
      );
    }
  }

  void tabButtonChange(int index) {
    setState(() {
      _tabButtonSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ///导航栏
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: YmAppBar(
                  widget.title,
                  background: [
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],
                  onBackClick: goBack,
                  textColor: Colors.white,
                ),
              ),
            ),

            Positioned(
              top: appBarHeight + 10,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: new ClampingScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) => this._getTabWidget(index)),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
