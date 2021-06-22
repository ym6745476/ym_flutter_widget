import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';
import 'config.dart';

mixin SingleNativeStateMixin<T extends StatefulWidget> on State<T> {

  bool isRouteFromFlutter = false;
  bool isLoading = true;
  bool isError = false;
  double appBarHeight = 76;

  //传值
  MethodChannel flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  MethodChannel nativeChannel = const MethodChannel("sample.flutter.io/native");

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      appBarHeight = MediaQuery.of(context).padding.top + 56;
    });

    //传值 设置监听
    nativeChannel.setMethodCallHandler(nativeCallHandler);

  }

  ///get请求数据
  Future<void> loadData() async{
    //需要覆盖
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
                  background:[
                  const Color(0xFF606FFF),
                  const Color(0xFF3446F2),
                ],onBackClick: goBack,textColor: Colors.white,),
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
        Config.isTest = arguments['test'];
        Config.token = arguments['token'];
        Config.userId = arguments['userId'];
        Config.isWeb = false;
        loadData();
        break;
    }
  }

  ///返回
  Future<void> goBack() async{
    if(isRouteFromFlutter){

      if(Navigator.canPop(context)){
        Navigator.pop(context,"");
        if(!Config.isWeb) {
          try {
            print('Flutter调用Native:onBack');
            Map<String, dynamic> arguments = {'message': 'onBack'};
            String result = await flutterChannel.invokeMethod('callNative', arguments);
            print('Flutter调用Native onBack:' + result);
          } on PlatformException catch (e) {}
        }
      }else{
        if(!Config.isWeb) {
          try {
            print('Flutter调用Native:onFinish');
            Map<String, dynamic> arguments = {'message': 'onFinish'};
            String result = await flutterChannel.invokeMethod('callNative', arguments);
            print('Flutter调用Native onFinish:' + result);
          } on PlatformException catch (e) {
            print("Failed: '${e.message}'.");
          }
        }
      }

    }else{
      try {
        print('Flutter调用Native:onFinish');
        Map<String, dynamic> arguments = {'message': 'onFinish'};
        String result = await flutterChannel.invokeMethod('callNative', arguments);
        print('Flutter调用Native onFinish:' + result);
      } on PlatformException catch (e) {
        print("Failed: '${e.message}'.");
      }
    }
  }

  ///Flutter调用原生
  Future<void> flutterCallNative(Map<String, dynamic> arguments) async{
    if(!Config.isWeb) {
      try {
        print('Flutter调用Native:flutterCallNative');
        String result = await flutterChannel.invokeMethod('callNative', arguments);
        print('Flutter调用Native:' + result);
      } on PlatformException catch (e) {}
    }
  }

}