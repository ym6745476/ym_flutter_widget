import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:video_player/video_player.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_router.dart';
import 'package:ym_flutter_widget/widgets/Video/ym_video_viewer.dart';

class VideoPage extends StatefulWidget {

  VideoPage({Key? key}) : super(key: key);

  final String title = "Video";

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with SingleNativeStateMixin{

  late VideoPlayerController _videoPlayerController;
  bool _isControllerInitialize = false;

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


  void _itemOnClick(String  path){

    if(_isControllerInitialize){
      _videoPlayerController.dispose();
    }

    YmUiUtil.showLoading(context);
    _videoPlayerController = VideoPlayerController.network(path)
      ..initialize().then((_) {
        print("VideoPlayerController initialize ok");
        _isControllerInitialize = true;
        YmUiUtil.hideLoading(context);
        Navigator.push(context, YmDialogRouter(
            YmVideoViewer(context,path, false,_videoPlayerController))
        );
      });

    _videoPlayerController.addListener(() {
      //print("isPlaying:" + _videoPlayerController.value.isPlaying.toString());
    });

    _videoPlayerController.setLooping(true);

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
              width:  MediaQuery.of(context).size.width,
              child:Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
                child:Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [

                      YmTextButton("点击播放", textColor:Color(0xFFFFFFFF),onClick:  (){
                        this._itemOnClick("http://bkt.ymbok.com/%E4%B8%96%E7%95%8C%E4%B8%8D%E4%BC%9A%E8%BD%BB%E6%98%93%E5%B4%A9%E5%A1%8C.mp4");
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

  @override
  void dispose() {
    if(_isControllerInitialize){
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

}