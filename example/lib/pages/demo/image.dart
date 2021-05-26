import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_router.dart';
import 'package:ym_flutter_widget/widgets/Image/ym_image_viewer.dart';

class ImagePage extends StatefulWidget {

  ImagePage({Key? key}) : super(key: key);

  final String title = "Image";

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  //和Native进行通信
  static const flutterChannel = const MethodChannel("sample.flutter.io/flutter");
  static const nativeChannel = const MethodChannel("sample.flutter.io/native");

  bool _isRouteFromFlutter = false;

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

  void _itemOnClick(String  path){
    Navigator.push(context, YmDialogRouter(
        YmImageViewer(context, path, false)
      )
    );
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
              width:  MediaQuery.of(context).size.width,
              child:Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
                child:Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "http://ymbok.com/upload/images/2021-05-22/202105221146294nVtMc.png",
                              fit:BoxFit.fitWidth,
                              width:(MediaQuery.of(context).size.width - 30)/3,
                              height:(MediaQuery.of(context).size.width - 30)/3 * 2,
                            ),
                          ],
                        ),
                        onTap: (){
                          this._itemOnClick("http://ymbok.com/upload/images/2021-05-22/202105221146294nVtMc.png");
                        }
                      ),
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