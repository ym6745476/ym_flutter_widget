import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/TabPageView/ym_tab_page_view.dart';

///
/// Tab+ListView
///
class TabPageViewPage extends StatefulWidget {
  TabPageViewPage({Key? key}) : super(key: key);

  final String title = "Tab Page View";

  @override
  _TabPageViewPageState createState() => _TabPageViewPageState();
}

class _TabPageViewPageState extends State<TabPageViewPage> with SingleNativeStateMixin {
  List<String> _tabs = ["全部", "已付款", "待付款"];
  int _tabSelectedIndex = 0;
  List<dynamic> _items = [];
  int _pageNumber = 1;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> onStart(Map<String, dynamic>? arguments) async{
    super.onStart(arguments);
    //加载数据
    print("TabPageViewPage onStart");
    _loadList();
  }

  void _tabChanged(index) {
    _tabSelectedIndex = index;

    setState(() {
      _hasMoreData = true;
      _pageNumber = 1;
    });
    _loadList();
  }

  Future<void> _loadList() async {
    print("_loadList _loadList _loadList");
    if (_pageNumber == 1) {
      _items.clear();
    }
    setState(() {
      for (int i = 0; i < 20; i++) {
        _items.add("Tab" + _tabSelectedIndex.toString() + ",第" + _pageNumber.toString() + "页,第" + i.toString() + "行");
      }
      _pageNumber = _pageNumber + 1;
    });

    if (_pageNumber == 5) {
      setState(() {
        _hasMoreData = false;
      });
    }
  }

  Widget _getListItemWidget(int index) {
    BoxDecoration boxDecoration = BoxDecoration(
      color: Color(0xffffffff),
      border: Border(
          top: BorderSide(color: Colors.white, width: 0), // 上边边框
          right: BorderSide(color: Colors.white, width: 0), // 右侧边框
          bottom: BorderSide(color: Colors.grey, width: 0.3), // 底部边框
          left: BorderSide(color: Colors.white, width: 0)), // 左侧边框
    );

    return Container(
        height: 50,
        decoration: boxDecoration,
        child: Padding(
            padding: EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
            child: Text(
              _items.elementAt(index).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w400, //字体宽度
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
              top: appBarHeight,
              left: 0,
              child: YmTabPageView(
                _tabs,
                _items,
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height - appBarHeight),
                tabBarHeight: 40,
                hasMoreData: _hasMoreData,
                onItemBuilder: (index) {
                  return _getListItemWidget(index);
                },
                onChanged: (index) {
                  _tabChanged(index);
                },
                onLoadMore: () {
                  _loadList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
