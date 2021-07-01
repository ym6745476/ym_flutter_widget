import 'dart:async';

import 'package:flutter/material.dart';

/// 循环滚动文本
class YmTextMarquee extends StatefulWidget {

  List<String> textArray = [];
  double initialScrollOffset;
  double itemHeight;

  YmTextMarquee(this.textArray,{this.initialScrollOffset = 0,this.itemHeight = 20});

  @override
  State<StatefulWidget> createState() {
    return _YmTextMarqueeState();
  }
}

class _YmTextMarqueeState extends State<YmTextMarquee> with WidgetsBindingObserver  {

  late ScrollController _controller;
  double currentScrollOffset = 0;
  GlobalKey _key = new GlobalKey();

  @override
  void initState() {

      _controller = new ScrollController(initialScrollOffset: widget.initialScrollOffset);

      //来监听 节点是否build完成
      WidgetsBinding? widgetsBinding = WidgetsBinding.instance;

      widgetsBinding!.addPostFrameCallback((callback){

        Timer.periodic(new Duration(seconds: 3), (timer){
          if(currentScrollOffset == widget.initialScrollOffset){
            _controller.jumpTo(widget.initialScrollOffset);
          }
          //滚动到底部从头开始
          if(_key.currentContext != null){
            if(currentScrollOffset + _key.currentContext!.size!.height.toInt() >= _controller.position.maxScrollExtent){
              _controller.animateTo(_controller.position.maxScrollExtent, duration: new Duration(seconds: 1), curve: Curves.easeOutSine);
              currentScrollOffset = widget.initialScrollOffset;
            }else{
              currentScrollOffset += _key.currentContext!.size!.height.toInt();
              _controller.animateTo((currentScrollOffset).toDouble(), duration: new Duration(seconds: 2), curve: Curves.easeOutSine);
            }
          }

        });

      });

      super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        key: _key,
        //禁止手动滑动
        physics: new NeverScrollableScrollPhysics(),
        itemCount: widget.textArray.length,
        //item固定高度
        itemExtent: widget.itemHeight,
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(widget.textArray[index],style: TextStyle(fontSize: 12,color:Colors.white),),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}