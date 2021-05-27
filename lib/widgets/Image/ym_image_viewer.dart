
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


///
/// Navigator.push(context, YmDialogRouter(YmImageViewer(context, posterPath, false)));
///
class YmImageViewer extends Dialog {

  ///点击背景是否能够退出
  final BuildContext context;
  final bool canceledOnTouchOutside;
  String mediaUrl;

  YmImageViewer(this.context,this.mediaUrl,this.canceledOnTouchOutside);

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
    Navigator.pop(context);
  }

  Widget _getContent(){

    return Image.network(
      mediaUrl,
      fit:BoxFit.contain,
      width:MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.6,
      loadingBuilder:(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
           if (loadingProgress == null){
             return child;
           }
           return Center(
             child:Padding(
               padding: EdgeInsets.all(20),
               child: CircularProgressIndicator(
                 value: loadingProgress.expectedTotalBytes != null
                     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                     : null,
               ),
             ),
           );
      },
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