import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';

class LoadingPage extends StatefulWidget {

  LoadingPage({Key? key}) : super(key: key);

  final String title = "Loading Page";

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleNativeStateMixin{

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
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              isLoading = false;
            });
          });

        }
      }
    });
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

              isLoading?Positioned(
                  top: appBarHeight,
                  left:0,
                  width:  MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height - appBarHeight,
                  child:YmLoading())
                  :Positioned(
                      top: 80,
                      left:0,
                      width:  MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height - appBarHeight,
                      child:Center(
                        child:Text("页面加载完成") ,
                      ),
                    ),
            ],
          ),
        ),
      );
  }

}