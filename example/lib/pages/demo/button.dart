import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_gradient_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_image_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_timer_button.dart';

///各种样式的文字按钮和图标按钮
class ButtonPage extends StatefulWidget {
  ButtonPage({Key? key}) : super(key: key);

  final String title = "Button";

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> with SingleNativeStateMixin {
  bool _enabled = true;
  late YmTimerButton _timerButton;

  @override
  void initState() {
    super.initState();

    /// 倒计时按钮
    _timerButton = YmTimerButton("获取验证码", hintText: "获取验证码", second: 60, size: Size(100, 40), onClick: () {
      startTimer();
    }, onTimeout: () {});
  }

  /// 开始倒计时
  void startTimer() {
    _timerButton.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ///导航栏
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: YmAppBar(
                  widget.title,
                  background: [
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],
                  onBackClick: goBack,
                  textColor: Colors.white,
                ),
              ),
            ),

            Positioned(
              top: appBarHeight,
              left: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
                  child: Wrap(spacing: 5, runSpacing: 5, children: [
                    YmTextButton("RoundedRectangle", textColor: Color(0xFFFFFFFF), onClick: () {
                      print("Button Pressed");
                    }),
                    YmTextButton(
                      "Stadium",
                      textColor: Color(0xFFFFFFFF),
                      onClick: () {
                        print("Button Pressed");
                      },
                      outlinedBorder: StadiumBorder(),
                    ),
                    YmTextButton("Circle", textColor: Color(0xFFFFFFFF), onClick: () {
                      print("Button Pressed");
                    }, outlinedBorder: CircleBorder()),
                    YmTextButton("RoundedRectangle", textColor: Color(0xFFFFFFFF), onClick: () {
                      print("Button Pressed");
                    }, outlinedBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    YmTextButton("BeveledRectangle", textColor: Color(0xFFFFFFFF), onClick: () {
                      print("Button Pressed");
                    }, outlinedBorder: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    YmTextButton("Outlined", textColor: Color(0xFF3446F2), onClick: () {
                      print("Button Pressed");
                    },
                        isOutlined: true,
                        borderColor: Color(0xFF3446F2),
                        outlinedBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    YmTextButton("Enable",
                        textColor: Color(0xFFFFFFFF),
                        backgroundColor: _enabled ? Color(0xFF3446F2) : Color(0xFFa1a3a6),
                        pressedBackgroundColor: Color(0xFFa1a3a6),
                        onClick: _enabled
                            ? () {
                                print("Button Pressed");
                                setState(() {
                                  _enabled = false;
                                });
                              }
                            : null,
                        outlinedBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 0),
                        child: YmImageButton("Button",
                            onClick: () {},
                            size: Size(100, 42),
                            textColor: Color(0xFF666666),
                            backgroundColor: Color(0xFFFFFFFF),
                            pressedBackgroundColor: Color(0xFFEFEFEF),
                            iconLeft: "assets/images/yf_download.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: YmImageButton("Button",
                            onClick: () {},
                            size: Size(100, 42),
                            textColor: Color(0xFF666666),
                            backgroundColor: Color(0xFFFFFFFF),
                            pressedBackgroundColor: Color(0xFFEFEFEF),
                            iconRight: "assets/images/yf_download.png"),
                      ),
                    ]),
                    YmImageButton("ImageButton", onClick: () {
                      print("Button Pressed");
                    },
                        textColor: Color(0xFFFFFFFF),
                        size: Size(160, 42),
                        backgroundColor: Color(0xFF3446F2),
                        pressedBackgroundColor: Color(0xFF606FFF),
                        iconLeft: "assets/images/yf_download.png"),
                    YmImageButton("ImageButton", onClick: () {
                      print("Button Pressed");
                    },
                        textColor: Color(0xFFFFFFFF),
                        size: Size(160, 42),
                        backgroundColor: Color(0xFF3446F2),
                        pressedBackgroundColor: Color(0xFF606FFF),
                        iconLeft: "assets/images/yf_download.png",
                        outlinedBorder: StadiumBorder()),
                    YmImageButton("ImageButton", onClick: () {
                      print("Button Pressed");
                    },
                        textColor: Color(0xFFFFFFFF),
                        size: Size(160, 42),
                        backgroundColor: Color(0xFF3446F2),
                        pressedBackgroundColor: Color(0xFF606FFF),
                        iconRight: "assets/images/yf_download.png",
                        outlinedBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    YmImageButton("ImageButton", onClick: () {
                      print("Button Pressed");
                    },
                        textColor: Color(0xFF3446F2),
                        size: Size(160, 42),
                        isOutlined: true,
                        iconRight: "assets/images/yf_download.png",
                        outlinedBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    YmGradientButton(
                      "GradientButton",
                      textColor: Color(0xFFFFFFFF),
                      onClick: () {
                        print("Button Pressed");
                      },
                      size: Size(MediaQuery.of(context).size.width - 32, 40),
                      fontSize: 14,
                      borderColor: Color(0xFF606FFF),
                      pressedBackgroundColor: Color(0xFF606FFF),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF606FFF), Color(0xFF3446F2)]),
                    ),
                    _timerButton
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
