import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';

///APP导航：左边返回键，中间/左边标题和右边按钮
class AppBarPage extends StatefulWidget {
  AppBarPage({Key? key}) : super(key: key);

  final String title = "AppBar自定义";

  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> with SingleNativeStateMixin {
  @override
  void initState() {
    super.initState();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFlutter = arguments["flutter"];
        if (!Config.isNative || isRouteFlutter) {
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
            ///导航栏1
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: YmAppBar(
                  widget.title,
                  background: [
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],
                  onBackClick: goBack,
                  textColor: Colors.white,
                ),
              ),
            ),

            ///导航栏2
            Positioned(
              top: appBarHeight + 30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: YmAppBar(
                  widget.title,
                  background: [
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],
                  onBackClick: goBack,
                  textColor: Colors.white,
                  textAlign: TextAlign.left,
                  rightWidget: YmTextButton("扫一扫",
                      textColor: Color(0xFFFFFFFF),
                      backgroundColor: Colors.transparent,
                      pressedBackgroundColor: Color(0x50606FFF),
                      size: Size(90, 40), onClick: () {
                    print("扫一扫");
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
