
import 'package:flutter/material.dart';
class YmLoading extends StatelessWidget {

  YmLoading() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: ShapeDecoration(
            color: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                color:Color(0xFF606FFF) ,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: new Text(
                  "加载中...",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF606FFF)
                  ),
                ),
              ),
            ],
          ),
    );
  }

}