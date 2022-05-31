import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ym_flutter_widget/compatible/ym_constants.dart';
import 'package:ym_flutter_widget/http/ym_http.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';
import 'config.dart';
import 'package:ym_flutter_widget/compatible/ym_compatible_js.dart' if (dart.library.html) 'dart:js' as js;

mixin SingleNativeStateMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = true;
  bool isError = false;
  double appBarHeight = 86;
  double appBottom = 0;
  double width = 0;
  double height = 0;
  List<Color> appBarColors = [const Color(0xFF606FFF), const Color(0xFF3446F2),];
  //传值
  MethodChannel flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  MethodChannel nativeChannel = const MethodChannel("sample.flutter.io/native");

  @override
  void initState() {
    super.initState();

    //传值 设置监听
    nativeChannel.setMethodCallHandler(nativeCallHandler);

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      initBuild(context);
      dynamic arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if(Navigator.canPop(context)){
        onStart(arguments);
      }
    });
  }

  ///在build里第一行设置UI属性
  void initBuild(BuildContext context) {
    setState(() {
      appBarHeight = MediaQuery.of(context).padding.top + 56;
      appBottom = MediaQuery.of(context).padding.bottom;
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    });
  }

  ///请求数据
  Future<void> onStart(Map<String, dynamic>? arguments) async {
    //token
    print("SingleNativeStateMixin onStart");
    YmHttp().setHeader({'token':Config.token});
  }

  Widget getLoadingWidget(String title){
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
                child: YmAppBar(title,
                  background:appBarColors,onBackClick: goBack,textColor: Colors.white,),
              ),
            ),
            ///Loading
            Positioned(
                top: appBarHeight,
                left:0,
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height - appBarHeight,
                child: YmLoading())
          ],
        ),
      ),
    );
  }

  ///原生调用Flutter
  Future<dynamic> nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case "callFlutter":
      //获取原生传来的值
        String jsonStr = call.arguments;
        print('Native调用Flutter:' + jsonStr);
        Map<String, dynamic> arguments = json.decode(jsonStr);
        Config.token = arguments['token'];
        Config.userId = arguments['userId'];
        onStart(arguments);
        break;
    }
  }

  ///返回
  Future<void> goBack() async{

    FocusScopeNode currentFocus = FocusScope.of(context);
    print("-------");
    /// 键盘是否是弹起状态
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }

    if(Navigator.canPop(context)){
      Navigator.pop(context,"");

      if(Config.platform == YmPlatform.android || Config.platform == YmPlatform.ios){
        flutterCallNative({'message': 'onBack'});
      }

    }else {
      if(Config.platform == YmPlatform.android || Config.platform == YmPlatform.ios) {
        flutterCallNative({'message': 'onFinish'});
      }else{
        js.context.callMethod("goBack");
      }
    }
  }

  ///Flutter调用原生
  Future<void> flutterCallNative(Map<String, dynamic> arguments) async{
    try {
      print('Flutter调用Native:' + json.encode(arguments));
      String result = await flutterChannel.invokeMethod('callNative', arguments);
      print('Flutter调用Native:' + result);
    } on Exception catch (e) {
      print("Failed: '$e'.");
    }
  }

  bool checkHttpError(int code) {
    if(code == 1000){
      flutterCallNative({'message': 'toLogin'});
      return false;
    }else{
      return true;
    }
  }

  @override
  void dispose() {
    YmHttp().cancelRequest();
    super.dispose();
  }
}
