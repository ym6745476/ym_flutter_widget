import 'package:example/base/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///和Native进行通信示例
class NativePage extends StatefulWidget {

  NativePage({Key? key}) : super(key: key);

  final String title = "Flutter与Native通信";

  @override
  _NativePageState createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {

  //和Native进行通信
  static const flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  static const nativeChannel = const MethodChannel("sample.flutter.io/native");

  String _resultMessage = "";
  bool _isRouteFromFlutter = false;


  @override
  void initState() {
    super.initState();

    //传值 设置监听
    nativeChannel.setMethodCallHandler(nativeCallHandler);

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
  }

  ///原生调用Flutter
  Future<dynamic> nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case "callFlutter":
        //获取原生传来的值
        String arguments = call.arguments;
        print('原生Android调用了flutter方法' + arguments);
        setState(() {
          _resultMessage = arguments;
        });
        Config.isWeb = false;
        Config.isTest = false;
        //加载数据
        break;
    }
  }

  ///Flutter调用原生
  Future<void> _callNative() async{
    if(_isRouteFromFlutter){
      Navigator.pop(context);
    }else{
      try {
        Map<String, dynamic> message = {'message': 'flutter'};
        String result = await flutterChannel.invokeMethod('callNative', message);
        setState(() {
          _resultMessage = result;
        });
      } on PlatformException catch (e) {
        setState(() {
          _resultMessage = "Failed: '${e.message}'.";
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //按钮
            Padding(
              padding: EdgeInsets.only(top:10,left: 16,right: 16,bottom: 10),
              child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      ElevatedButton(
                        child: Text('调用Native'),
                        onPressed: _callNative,
                      ),

                    ],
                  ),
              ),

              //结果
              Padding(
                padding: EdgeInsets.only(top:5,left: 0,right: 0,bottom: 0),
                child:  Text(_resultMessage),
              ),

          ],
        ),
      ),
    );
  }
}