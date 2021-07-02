import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 滚动选择器
class YmPicker extends StatefulWidget {

  //默认值
  final String value;
  //数据格式：{"label": "请选择", "value": ""}
  final List<Map> data;

  //前方文字
  final String label;
  final double width;
  final double height;
  final Function onChanged;

  final double itemHeight;
  final Color backgroundColor;

  YmPicker(
      this.data,
      this.value,
      {
        Key? key,
        this.label = "",
        this.itemHeight = 36,
        this.backgroundColor = const Color(0xffffffff),
        this.height = 150,
        this.width = 150,
        required this.onChanged,
      }
      ): super(key: key);

  @override
  YmPickerState createState() => YmPickerState();

}

class YmPickerState extends State<YmPicker> {

  //设置防抖周期为300毫秒
  Duration _durationTime = const Duration(milliseconds: 300);
  Timer _timer = Timer(Duration(milliseconds: 300), () {});
  int _currentIndex = 0;
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    print("YmPickerState initState");
    _currentIndex =  _getDefaultIndex();
    _controller = FixedExtentScrollController(initialItem: _currentIndex);
  }

  @override
  void didUpdateWidget(YmPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _currentIndex = _getDefaultIndex();
    });

    //更新数据后选中第一个数据
    _controller.jumpToItem(_currentIndex);
    print("YmPickerState didUpdateWidget default index:" + _currentIndex.toString());
  }

  // 获取默认选择值的位置
  int _getDefaultIndex() {
    for (var i = 0; i < widget.data.length; i++) {
      if (widget.data[i]["value"] == widget.value) {
        return i;
      }
    }
    return 0;
  }

  // 触发值改变
  void _valueChanged(index) {
    _timer.cancel();
    _timer = new Timer(_durationTime, () {
      // 触发回调函数
      print("values长度：" + widget.data.length.toString() + "-----" + index.toString());
      widget.onChanged(index,widget.data[index]["value"]);
    });
  }

  Widget _getItemWidget(int index,List<Map> items){
    return Container(
      alignment: Alignment.center,
      height: widget.itemHeight,
      child: Text(
        items.elementAt(index)["label"],
        style: TextStyle(
          color: Color(0xff333333),
          fontSize: 15,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: CupertinoPageScaffold(

        child: Container(
          height: widget.height,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              widget.label != "" ? Positioned(
                top: widget.height / 2 - (widget.itemHeight / 2),
                left: 18.0,
                child: Container(
                  alignment: Alignment.center,
                  height: widget.itemHeight,
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ) : Offstage(offstage: true,),

              CupertinoPicker.builder(
                magnification: 1.0,                   // 整体放大率
                scrollController:_controller,
                itemExtent: widget.itemHeight,        // 所有子节点统一高度
                useMagnifier: true,                   // 是否使用放大效果
                backgroundColor: Colors.transparent,
                childCount: widget.data.length,
                onSelectedItemChanged: (int index) {
                  // 当选项改变时的回调
                  if (mounted) {
                    print('onSelectedItemChanged:$index');
                    _valueChanged(index);
                  }
                },
                itemBuilder: (BuildContext context, int index) {
                  return _getItemWidget(index,widget.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}