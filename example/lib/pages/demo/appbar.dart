import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';

class AppBarPage extends StatefulWidget {

  AppBarPage({Key? key}) : super(key: key);

  final String title = "AppBar自定义";

  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> with SingleNativeStateMixin{

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
              height: MediaQuery.of(context).size.height - appBarHeight ,
              width:  MediaQuery.of(context).size.width,
              child: Container(
                child:MediaQuery.removePadding(
                  removeTop:true,
                  context:context,
                  child:Center(
                    child: Text("YmAppBar和自定义返回键"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}