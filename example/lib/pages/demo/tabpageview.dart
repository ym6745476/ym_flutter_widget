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

  List<String> _tabs = ["全部","已付款","待付款"];
  List<dynamic> _items = [];

  @override
  void initState() {
    super.initState();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic  arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFromFlutter = arguments["flutter"];
        if(Config.isWeb || isRouteFromFlutter){
          //加载数据
        }
      }
    });

    _items.clear();
    _items.add("第一行0");
    _items.add("第二行0");
    _items.add("第三行0");
    _items.add("第四行0");
    _items.add("第五行0");

  }

  Widget _getListItemWidget(int index){
    BoxDecoration boxDecoration = BoxDecoration( color: Color(0xffffffff),
        border: Border(
        top: BorderSide(color: Colors.white, width: 0),     // 上边边框
        right: BorderSide(color: Colors.white, width: 0),   // 右侧边框
        bottom: BorderSide(color: Colors.grey, width: 0.3),   // 底部边框
        left: BorderSide(color: Colors.white, width: 0)),   // 左侧边框
    );

    return Container(
        height:50,
        decoration:boxDecoration ,
        child:Padding(
            padding: EdgeInsets.only(top:10,left: 0,right: 0,bottom: 10),
            child:Text(
                _items.elementAt(index).toString(),
                textAlign:TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,    //字体宽度
                ),
            )
        )
    );
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
                child: YmAppBar(widget.title,[
                  const Color(0xFF606FFF),
                  const Color(0xFF3446F2),
                ],goBack,titleTextColor: Colors.white,),
              ),
            ),

            Positioned(
              top: 100,
              left:16,
              child:YmTabPageView(_tabs,_items,
                size: Size(MediaQuery.of(context).size.width-32, MediaQuery.of(context).size.height-100),
                onItemBuilder: (index){
                  return _getListItemWidget(index);
                },
                onChanged:(index){
                  setState(() {
                    _items.clear();
                    _items.add("第一行" + index.toString());
                    _items.add("第二行" + index.toString());
                    _items.add("第三行" + index.toString());
                    _items.add("第四行" + index.toString());
                    _items.add("第五行" + index.toString());
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}