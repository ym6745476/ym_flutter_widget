import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/ListView/ym_list_view.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';
import 'package:ym_flutter_widget/widgets/TabPageView/ym_tab_page_view.dart';

///
/// ListView 带加载更多
///
class ListViewPage extends StatefulWidget {

  ListViewPage({Key? key}) : super(key: key);

  final String title = "List View";

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> with SingleNativeStateMixin {

  List<dynamic> _items = [];
  int _pageNumber = 1;
  bool _hasMoreData = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic  arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFromFlutter = arguments["flutter"];
        if(Config.isWeb || isRouteFromFlutter){
          //加载数据
          loadData();
        }
      }
    });
  }

  @override
  Future<void> loadData() async{
    _loadList();
  }

  Future<void> _loadList() async{
    Future.delayed(Duration(seconds: 2), () {
      if(_pageNumber == 1){
        _items.clear();
      }
      setState(() {
        for(int i= 0;i<20;i++){
          _items.add("第" + _pageNumber.toString() + "页,第"+i.toString()+"行");
        }
        _pageNumber = _pageNumber + 1;
      });

      setState(() {
        isLoading = false;
      });

      if(_pageNumber == 5){
        setState(() {
          _hasMoreData = false;
        });
      }
    });
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

              isLoading?Positioned(
                  top: appBarHeight,
                  left:0,
                  width:  MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height - appBarHeight,
                  child:YmLoading())
                  :Positioned(
                    top: MediaQuery.of(context).padding.top + 56,
                    left:0,
                    child:YmListView(_items,
                      _scrollController,
                      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height - appBarHeight),
                      hasMoreData: _hasMoreData,
                      onItemBuilder: (index){
                        return _getListItemWidget(index);
                      },
                      onLoadMore: (){
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