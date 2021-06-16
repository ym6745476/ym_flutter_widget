import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/Html/ym_html.dart';

class HtmlPage extends StatefulWidget {

  HtmlPage({Key? key}) : super(key: key);

  final String title = "Html Page";

  @override
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> with SingleNativeStateMixin {

  late ScrollController _controller = ScrollController();
  Color _backButtonColor = Color(0xff999999);
  String _titleText = "";



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

    _controller.addListener(() {
      //print('_controller offset : ${_controller.offset}');
      if (_controller.offset > 100) {
        if(_titleText == ""){
          setState(() {
            _backButtonColor = Color(0xffffffff);
            _titleText = "Html Page";
          });
        }
      } else if(_titleText != ""){
        setState(() {
          _backButtonColor = Color(0xffffffff);
          _titleText = "";
        });
      }
    });

  }


  @override
  Widget build(BuildContext context) {

    String html = "<html><head></head><body><p>关于：Ym Flutter Widget</p><p>A Light Weight Flutter Widget (Including Http,AppBar,Dialog,Toast,Cascader,Loading,Button,SearchBar,Html,Image,Video and so on).</p><p>学习Flutter最好的资源，新手友好，尽量纯Dart源码实现，避免依赖太多第三方导致维护困难。来源于实际项目，具有高度可定制性。</p><p></p><p><img src=\"http://case.ymbok.com:8082/public/20210527084021Pwkc1R.png\"></p><p></p><p><img src=\"http://case.ymbok.com:8082/public/20210527084021Pwkc1R.png\"></p><p></p><p><img src=\"http://case.ymbok.com:8082/public/20210527084021Pwkc1R.png\"></p></body></html>";
    return MaterialApp(
        home: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[

              Positioned(
                  top: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomScrollView(
                     //physics: BouncingScrollPhysics(), //ios风格的上拉出来空白
                      physics: ClampingScrollPhysics(),
                      reverse: false,
                      controller: _controller,
                      slivers: <Widget>[
                        SliverAppBar(
                          title: Text(_titleText),
                          centerTitle: true,
                          leading: IconButton(
                            icon: new Icon(Icons.arrow_back_ios),
                            color: _backButtonColor,
                            onPressed: goBack,
                            iconSize: 28,
                          ),
                          expandedHeight: 150,
                          pinned: true,
                          //AppBar是否固定在顶部
                          floating: false,
                          backgroundColor: Color(0x903446F2),
                          //SliverAppBar背景色
                          flexibleSpace: FlexibleSpaceBar(
                            //titlePadding: EdgeInsets.fromLTRB(50, 0, 0, 17),
                            centerTitle: true,
                            title: Text(""),

                            background: Container(
                              ///背景图
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                child: Image.network(
                                  "http://case.ymbok.com:8082/public/20210527084021Pwkc1R.png",
                                  fit: BoxFit.fitWidth,
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SliverPadding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(
                                <Widget>[
                                  Container(
                                      margin: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
                                                child: YmHtml(html,MediaQuery.of(context).size.width),
                                            ),
                                          ]
                                      )
                                  ),
                                ],
                              ),
                            )),
                      ]
                  )
              ),
            ],
          ),
        ),
      );
  }

}