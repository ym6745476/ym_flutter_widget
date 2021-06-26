
import 'package:flutter/material.dart';

/// 自定义标题栏
class YmAppBar extends StatelessWidget {

  final String title;                            // 标题名称
  final TextAlign textAlign;                     // 标题方向
  final List<Color> background;                  // 背景颜色
  final double barHeight = 56;                   // 标题栏高度
  final Function() onBackClick;                  // 返回
  final Color textColor;                         // 文本标题的颜色
  final Widget? rightWidget;                     //右边内容

  ///构造方法传入标题栏
  YmAppBar(this.title,
      {
        this.textColor = Colors.black,
        this.background = const [
          const Color(0xFF606FFF),
          const Color(0xFF3446F2),
        ],
        required this.onBackClick,
        this.rightWidget,
        this.textAlign = TextAlign.center,
      });

  @override
  Widget build(BuildContext context) {
    //获取系统状态栏高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight,left:10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: background
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width:barHeight,
            height:barHeight,
            child:IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              color: this.textColor,
              onPressed: onBackClick,
              iconSize: 28,
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right:rightWidget == null?barHeight:0),
              child: Text(
                title,
                textAlign:this.textAlign,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,    //字体宽度
                ),
              ),
            ),
          ),

          Container(
            height:barHeight,
            child: rightWidget == null?Container():rightWidget,
          ),

        ],
      ),
    );
  }
}