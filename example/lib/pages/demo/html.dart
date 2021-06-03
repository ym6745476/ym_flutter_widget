import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Empty/ym_empty.dart';
import 'package:ym_flutter_widget/widgets/Error/ym_error.dart';
import 'package:ym_flutter_widget/widgets/Html/ym_html.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';
import 'package:ym_flutter_widget/widgets/Toast/ym_toast.dart';

class HtmlPage extends StatefulWidget {

  HtmlPage({Key? key}) : super(key: key);

  final String title = "Html Page";

  @override
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {

  //和Native进行通信
  static const flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  static const nativeChannel = const MethodChannel("sample.flutter.io/native");

  bool _isRouteFromFlutter = false;

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
        _isRouteFromFlutter = arguments["flutter"];
        if(Config.isWeb || _isRouteFromFlutter){
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

  ///Flutter调用原生
  Future<void> _goBack() async{
    if(_isRouteFromFlutter){
      //如果是Flutter导航进来的页面直接退出
      Navigator.pop(context);
    }else{
      //如果该页面是Native直接打开的，发送完成消息给Native处理
      try {
        Map<String, dynamic> arguments = {'message': 'onFinish'};
        String result = await flutterChannel.invokeMethod('callNative', arguments);
        print(result);
      } on PlatformException catch (e) {
        print("Failed: '${e.message}'.");
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    String html = "<html><head></head><body><p>关于：Ym Flutter Widget</p><p>A Light Weight Flutter Widget (Including Http,JsonToBean,AppBar,Dialog,Toast,Cascader,Loading,Button,SearchBar,Html,Image,Video and so on).</p><p>学习Flutter最好的资源，新手友好，尽量纯Dart源码实现，避免依赖太多第三方导致维护困难。来源于实际项目，具有高度可定制性。</p><p></p><p><img src=\"http://ymbok.com/upload/images/sample/20210527084021Pwkc1R.png\"></p><p></p><p><img src=\"http://ymbok.com/upload/images/sample/20210527084021Pwkc1R.png\"></p><p></p><p><img src=\"http://ymbok.com/upload/images/sample/20210527084021Pwkc1R.png\"></p></body></html>";
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
                            onPressed: _goBack,
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
                                  "http://ymbok.com/upload/images/sample/20210527084021Pwkc1R.png",
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