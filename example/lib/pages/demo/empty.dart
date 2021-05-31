import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Empty/ym_empty.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';
import 'package:ym_flutter_widget/widgets/Toast/ym_toast.dart';

class EmptyPage extends StatefulWidget {

  EmptyPage({Key? key}) : super(key: key);

  final String title = "Empty Page";

  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {

  //和Native进行通信
  static const flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  static const nativeChannel = const MethodChannel("sample.flutter.io/native");

  bool _isRouteFromFlutter = false;
  bool _isLoading = true;

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


    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

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
                  child: YmAppBar(widget.title,[
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],_goBack,titleTextColor: Colors.white,),
                ),
              ),

              _isLoading?Positioned(
                  top: 80,
                  left:0,
                  width:  MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height - 80,
                  child:YmLoading())
                  :Positioned(
                  top: 80,
                  left:0,
                  width:  MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height - 80,
                  child:YmEmpty("暂无数据","assets/images/ic_no_data.png")
              ),

            ],
          ),
        ),
      );
  }


}