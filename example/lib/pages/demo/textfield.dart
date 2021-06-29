import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/TextField/ym_text_field.dart';
import 'package:ym_flutter_widget/widgets/TextField/ym_text_marquee.dart';

class TextFieldPage extends StatefulWidget {

  TextFieldPage({Key? key}) : super(key: key);

  final String title = "TextField";

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> with SingleNativeStateMixin{

  String _name = "";

  List<String> _textArray = [
    "循环滚动文字1111111111111111111111111111111",
    "循环滚动文字2222222222222222222222222222222",
    "循环滚动文字3333333333333333333333333333333",
    "循环滚动文字4444444444444444444444444444444",
    "循环滚动文字5555555555555555555555555555555",
  ];

  @override
  void initState() {
    super.initState();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic  arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFlutter = arguments["flutter"];
        if(!Config.isNative || isRouteFlutter){
          //加载数据
        }
      }
    });
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
                child: YmAppBar(widget.title,
                  background:[
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],onBackClick: goBack,textColor: Colors.white,),
              ),
            ),

            Positioned(
              top: appBarHeight,
              left:0,
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height - appBarHeight,
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

                    Padding(
                      padding: EdgeInsets.only(top:10,left:16,right: 16,bottom: 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, style: BorderStyle.solid,color: Color(0xffefefef)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                            colors: [Color(0xff606FFF),Color(0xff606FFF)],
                          ),
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(top:2,left:10,right: 10,bottom: 2),
                          child:YmTextMarquee(_textArray,initialScrollOffset: 24,),
                        ),
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
