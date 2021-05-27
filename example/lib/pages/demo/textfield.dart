import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/TextField/ym_text_field.dart';

class TextFieldPage extends StatefulWidget {

  TextFieldPage({Key? key}) : super(key: key);

  final String title = "TextField";

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {

  //和Native进行通信
  static const flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  static const nativeChannel = const MethodChannel("sample.flutter.io/native");

  bool _isRouteFromFlutter = false;

  String _name = "";

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

  void onNameTextChange(text){
    print("onTextChange:$text");
    this._name = text;
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

            Positioned(
              top: 80,
              left:0,
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height - 80,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding: EdgeInsets.only(top:10,left:16,right: 16,bottom: 10),
                        child:YmTextField([NumberTextInputFormatter()],_name,onNameTextChange,
                          fontSize: 15,
                          height: 35,
                          hintText:"基本输入框" ,
                          outlineInputBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(color: Color(0x00606FFF))
                          ),
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(color: Color(0x003446F2))
                          ),
                        ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top:10,left:16,right: 16,bottom: 0),
                      child:YmTextField([],_name,onNameTextChange,
                        fontSize: 15,
                        height: 80,
                        hintText:"多行文本框" ,
                        outlineInputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Color(0xFFCCCCCC))
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Color(0x803446F2))
                        ),
                        maxLines: 5,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top:10,left:16,right: 16,bottom: 0),
                      child:YmTextField([FilteringTextInputFormatter.allow(RegExp("[0-9.]")),NumberTextInputFormatter()],_name,onNameTextChange,
                        fontSize: 15,
                        height: 35,
                        hintText:"数值文本框" ,
                        outlineInputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Color(0xFFCCCCCC))
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Color(0x803446F2))
                        ),
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}