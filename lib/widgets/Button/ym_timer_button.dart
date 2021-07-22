import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';

/// 显示倒计时的按钮
class YmTimerButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String hintText;
  final int second;
  final Size size;
  final void Function() onClick;
  final void Function() onTimeout;
  Function startTimer = () {};

  YmTimerButton(
    this.text, {
    required this.hintText,
    required this.second,
    required this.onClick,
    required this.onTimeout,
    this.fontSize = 14,
    this.size = const Size(120, 42),
    this.fontWeight = FontWeight.normal,
    this.textColor = const Color(0xFF666666),
  });

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<YmTimerButton> {
  late String text;
  Timer? timer;
  late int second;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      second--;
      if (second == 0) {
        setState(() {
          second = widget.second;
          text = widget.hintText;
        });
        timer!.cancel();
        timer = null;
        widget.onTimeout();
      } else {
        setState(() {
          text = second.toString() + "s";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    text = widget.text;
    second = widget.second;
    widget.startTimer = this.startTimer;
  }

  @override
  Widget build(BuildContext context) {
    return YmTextButton(text,
        textColor: Color(0xFFFFFFFF),
        size: widget.size,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight, onClick: () {
      if (second == widget.second) {
        widget.onClick();
      }
    }, outlinedBorder: StadiumBorder());
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    super.dispose();
  }
}
