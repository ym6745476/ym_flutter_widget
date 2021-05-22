
import 'package:flutter/material.dart';
class YmLoading extends StatelessWidget {

  YmLoading() : super();

  @override
  Widget build(BuildContext context) {
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