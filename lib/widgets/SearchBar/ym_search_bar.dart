import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 有圆角和图标的搜索框
class YmSearchBar extends StatefulWidget {
  ///搜索框上默认的文本
  String text;

  ///搜索框上显示的文案
  String hint;

  ///搜索框的圆角
  double borderRadius;
  EdgeInsets margin;
  EdgeInsets padding;

  ///如果考虑不需要水波纹效果那么就可以设置颜色为透明色
  Color splashColor;

  ///文本输入框焦点控制
  FocusNode? focusNode;

  ///文本输入框控制器
  TextEditingController? controller;

  ///点击键盘上的回车键的回调
  Function(String text)? onSubmitted;
  Function(String text)? onChanged;

  ///清楚搜索回调
  Function? clearCallback;

  ///返回键的回调
  Function()? onBackCallback;

  ///输入文本的长度限制
  int inputKeyWordsLength;

  ///输入框文字大小
  double fontSize;

  ///是否显示左侧的返回键
  bool isShowBackButton;

  ///搜索框的长度
  double width;

  ///搜索框的高度
  double height;

  YmSearchBar(
      {this.text = "",
      this.hint = "搜索",
      this.borderRadius = 30.0,
      this.margin = const EdgeInsets.only(top: 10.0, bottom: 10.0),
      this.padding = const EdgeInsets.only(left: 12),
      this.splashColor = const Color(0xFFD6D6D6),
      this.focusNode,
      this.controller,
      this.onSubmitted,
      this.onChanged,
      this.onBackCallback,
      this.clearCallback,
      this.inputKeyWordsLength = 20,
      this.fontSize = 14,
      this.isShowBackButton = false,
      this.width = 200,
      this.height = 60});

  @override
  State<StatefulWidget> createState() {
    return SearchTextFieldBarState();
  }
}

class SearchTextFieldBarState extends State<YmSearchBar> {
  ///为true 时显示清除选项
  bool showClear = false;

  ///文本输入框的默认使用控制器
  late TextEditingController defaultController;

  @override
  void initState() {
    super.initState();

    ///默认的Controller
    if (widget.controller == null) {
      defaultController = TextEditingController.fromValue(TextEditingValue(
          // 设置内容
          text: widget.text,
          // 保持光标在最后
          selection:
              TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: widget.text.length))));
    }

    ///创建默认的焦点控制
    if (widget.focusNode == null) {
      widget.focusNode = new FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      ///外边距
      margin: widget.margin,

      ///水平方向线性排列
      child: Row(
        children: [
          ///左侧的返回按钮
          buildLeftBackWidget(),

          ///右侧的搜索框内容区域
          buildContentContainer(),
        ],
      ),
    );
  }

  ///构建左侧的返回按钮
  Widget buildLeftBackWidget() {
    ///当用在APPBar的位置时
    ///常常需要配合一个返回按钮
    if (widget.isShowBackButton) {
      ///返回键按钮
      return BackButton(
        color: Colors.white,
        onPressed: () {
          ///返回事件回调
          if (widget.onBackCallback != null) {
            widget.onBackCallback!();
          } else {
            ///直接关闭当前页面
            Navigator.of(context).pop();
          }
        },
      );
    } else {
      ///当不需要显示返回按钮时
      ///设置一个空视图
      return Container();
    }
  }

  ///构建搜索框的显示区域[Container]
  LayoutBuilder buildContainer(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return buildContentContainer();
    });
  }

  ///构建搜索框的显示区域[Container]
  Container buildContentContainer() {
    return Container(
      height: widget.height,

      ///获取当前StatelessWidget的宽度
      width: widget.width,

      ///对齐方式
      alignment: Alignment(-1, 0),

      ///内边距
      padding: widget.padding,

      ///圆角边框
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(width: 0.5, style: BorderStyle.solid, color: Color(0XFFEFEFEF)),
      ),
      child: buildRow(),
    );
  }

  ///构建搜索图标与显示文本
  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ///左侧的搜索图标
        Icon(
          Icons.search,
          color: Colors.blue,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),

        SizedBox(
          width: 8.0,
        ),

        ///中间的输入框
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment(-1, 0),
            child: buildTextField(),
          ),
        ),

        ///右侧的清除小按钮
        buildClearButton(),
      ],
    );
  }

  ///lib/demo/search_textfield_bar.dart
  ///构建搜索输入TextField
  TextField buildTextField() {
    return TextField(
      ///设置键盘的类型
      keyboardType: TextInputType.text,

      ///键盘回车键的样式为搜索
      textInputAction: TextInputAction.search,

      ///只有苹果手机上有效果
      keyboardAppearance: Brightness.dark,

      ///控制器配置
      controller: widget.controller == null ? defaultController : widget.controller,

      ///最大行数
      maxLines: 1,

      ///输入文本格式过滤
      inputFormatters: [
        ///输入的内容长度限制
        LengthLimitingTextInputFormatter(widget.inputKeyWordsLength),
      ],

      ///当输入文本时实时回调
      onChanged: (text) {
        ///多层判断 优化刷新
        ///只有当有改变时再刷新
        if (text.length > 0) {
          if (!showClear) {
            setState(() {
              showClear = true;
            });
          }
        } else {
          if (showClear) {
            setState(() {
              showClear = false;
            });
          }
        }

        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
      },

      ///点击键盘上的回车键
      ///或者是搜索按钮的回调
      onSubmitted: (text) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(text);
        }
      },

      ///输入框不自动获取焦点
      autofocus: false,
      focusNode: widget.focusNode,

      style: TextStyle(fontSize: widget.fontSize, color: Colors.black54, fontWeight: FontWeight.w300),

      ///输入框的边框装饰
      decoration: InputDecoration(
          //重要 用于编辑框对齐
          isDense: true,

          ///清除文本内边跑
          contentPadding: EdgeInsets.zero,

          ///不设置边框
          border: InputBorder.none,

          ///设置提示文本
          hintText: widget.hint,

          ///设置提示文本的样式
          hintStyle: TextStyle(
            fontSize: widget.fontSize,
            color: Color(0xff999999),
          )),
    );
  }

  ///清除按键
  ///当文本框有内容输入时显示清除按钮
  buildClearButton() {
    ///当文本输入框中有内容时才显示清除按钮
    if (showClear) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          size: 24.0,
          color: Color(0xffacacac),
        ),
        onPressed: () {
          if (widget.controller == null) {
            defaultController.clear();
          } else {
            widget.controller!.clear();
          }
          setState(() {
            showClear = false;
          });
          if (widget.clearCallback != null) {
            widget.clearCallback!();
          }
        },
      );
    } else {
      return Container();
    }
  }
}
