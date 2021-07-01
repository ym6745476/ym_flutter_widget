
import 'package:flutter/material.dart';

///加载框
class YmLoadingDialog extends Dialog {

  ///点击背景是否能够退出
  final bool canceledOnTouchOutside;

  YmLoadingDialog(this.canceledOnTouchOutside) : super();

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
                    Navigator.pop(context);
                  }
                },
              ),
              _dialog()
            ],
          )
      ),
    );
  }

  Widget _dialog(){
    return new Center(
      ///弹框大小
      child: new SizedBox(
        width: 120,
        height: 120,
        child: new Container(
          ///弹框背景和圆角
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: new Text(
                  "加载中...",
                  style: new TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}