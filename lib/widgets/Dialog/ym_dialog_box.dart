import 'package:flutter/material.dart';

/// 弹出层样式(用于包裹一个Widget,显示到任意方向上)
class YmDialogBox extends StatelessWidget {
  final Widget? child;
  final Alignment alignment;
  final Function() onClick;

  YmDialogBox({
    Key? key,
    this.child,
    required this.onClick,
    this.alignment = Alignment.bottomCenter,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? current = child;

    if (child == null) {
      current = LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      );
    }
    current = Align(alignment: alignment, child: current);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(color: Color(0x96000000)),
        child: current
      ),
      onTap: () {
        onClick();
      },
    );
  }
}
