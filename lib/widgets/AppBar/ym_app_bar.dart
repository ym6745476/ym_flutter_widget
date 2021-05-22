
import 'package:flutter/material.dart';

/// 自定义标题栏
class YmAppBar extends StatelessWidget {

  final String title;                            // 标题名称
  final List<Color> background;                  // 背景颜色
  final int barHeight = 80;                      // 标题栏高度
  final Function() backAction;                   // 返回
  final Color titleTextColor;                    // 文本标题的颜色

  ///构造方法传入标题栏
  YmAppBar(this.title,this.background, this.backAction,{this.titleTextColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    //获取系统状态栏高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight,left:10),
      height: barHeight + 0.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: background
        ),
      ),
      child:new Row(
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            color: this.titleTextColor,
            onPressed: backAction,
            iconSize: 28,
          ),

          Expanded(
            child: Container(
               padding: EdgeInsets.only(right:60),
               child:Text(
                 title,
                 textAlign:TextAlign.center,
                 style: TextStyle(
                   color: this.titleTextColor,
                   fontSize: 20,
                   fontWeight: FontWeight.w400,    //字体宽度
                 ),
               ),
          )
          ),
        ],
      ),
    );
  }
}