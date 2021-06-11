import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';

class DialogPage extends StatefulWidget {

  DialogPage({Key? key}) : super(key: key);

  final String title = "Dialog";

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> with SingleNativeStateMixin{

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

  void alertDialog(){
    YmUiUtil.showAlertDialog(context, "确认提示", "您确定要打开弹窗吗?", "确定", "取消",onOkPressed: (){
      print("Ok Pressed");
    });
  }

  void loadingDialog(){
    YmUiUtil.showLoading(context);

    Future.delayed(Duration(seconds: 3), () {
      YmUiUtil.hideLoading(context);
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
                child: YmAppBar(widget.title,[
                  const Color(0xFF606FFF),
                  const Color(0xFF3446F2),
                ],goBack,titleTextColor: Colors.white,),
              ),
            ),

            Positioned(
              top:appBarHeight,
              left:0,
              width:  MediaQuery.of(context).size.width,
              child:Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
                child:Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [

                      YmTextButton("Loading Dialog", Color(0xFFFFFFFF), (){
                        loadingDialog();
                      },outlinedBorder: StadiumBorder(),),

                      YmTextButton("Alert Dialog", Color(0xFFFFFFFF), (){
                        alertDialog();
                      },outlinedBorder: StadiumBorder(),),

                    ]
                )
              ),
            ),

          ],
        ),
      ),
    );
  }


}