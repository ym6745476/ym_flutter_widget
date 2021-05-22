
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


///
/// Navigator.push(context, YmDialogRouter(
///     YmVideoViewer(context, posterPath, false,videoController:_videoPlayerController)));
///
class YmVideoViewer extends Dialog {

  ///点击背景是否能够退出
  final BuildContext context;
  final bool canceledOnTouchOutside;
  String mediaUrl;
  late VideoPlayerController controller;

  YmVideoViewer(this.context,this.mediaUrl,this.canceledOnTouchOutside,{VideoPlayerController? videoController}){

    if(videoController!=null){
      this.controller = videoController;
    }
    //this.mediaUrl = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    if(this.mediaUrl.indexOf(".mp4")!=-1){
        print("video:" + this.mediaUrl);

        Future.delayed(Duration(seconds: 1), () {
          this.controller.play();
        });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: new Material(
          ///背景透明
          color: Colors.transparent,
          ///保证控件居中效果
          child: Stack(
            children: <Widget>[
              GestureDetector(
                ///点击事件
                onTap: (){
                  if(canceledOnTouchOutside){
                      closeDialog();
                  }
                },
              ),
              _dialog()
            ],
          )
      ),
    );
  }

  void closeDialog(){
    controller.pause();
    Navigator.pop(context);
  }

  Widget _getContent(){
    print("aspectRatio:" + controller.value.aspectRatio.toString());
    return SizedBox(
        width:MediaQuery.of(context).size.width * 0.7,
        child:new AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller))
    );
  }

  Widget _dialog(){
    return Center(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width:MediaQuery.of(context).size.width * 0.8 ,
                    alignment: AlignmentDirectional.bottomEnd,
                    child:
                      IconButton(icon: Image.asset('assets/images/ic_close.png'), iconSize: 30.0, onPressed: (){
                          closeDialog();
                      }),
                  ),

                  _getContent(),
                ],
          ),
    );
  }
}