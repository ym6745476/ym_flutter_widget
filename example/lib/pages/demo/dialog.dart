import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_box.dart';

class DialogPage extends StatefulWidget {
  DialogPage({Key? key}) : super(key: key);

  final String title = "Dialog";

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> with SingleNativeStateMixin {
  bool _showBoxDialog = false;

  @override
  void initState() {
    super.initState();
  }

  void alertDialog() {
    YmUiUtil.showAlertDialog(context, "确认提示", "您确定要打开弹窗吗?", "确定", "取消", onOkPressed: () {
      print("Ok Pressed");
    });
  }

  void loadingDialog() {
    YmUiUtil.showLoading(context);

    Future.delayed(Duration(seconds: 3), () {
      YmUiUtil.hideLoading(context);
    });
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
                    YmTextButton(
                      "Loading Dialog",
                      textColor: Color(0xFFFFFFFF),
                      onClick: () {
                        loadingDialog();
                      },
                      outlinedBorder: StadiumBorder(),
                    ),
                    YmTextButton(
                      "Alert Dialog",
                      textColor: Color(0xFFFFFFFF),
                      onClick: () {
                        alertDialog();
                      },
                      outlinedBorder: StadiumBorder(),
                    ),
                    YmTextButton(
                      "Box Dialog",
                      textColor: Color(0xFFFFFFFF),
                      onClick: () {
                        setState(() {
                          _showBoxDialog = !_showBoxDialog;
                        });
                      },
                    ),
                  ])),
            ),

            _showBoxDialog
                ? Positioned(
                    top: appBarHeight + 120,
                    left: 0,
                    height: MediaQuery.of(context).size.height - appBarHeight - 120,
                    width: MediaQuery.of(context).size.width,
                    child: YmDialogBox(
                      alignment: Alignment.topLeft,
                      onClick: (){},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "任意位置，任意内容",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: YmTextButton(
                                    "重置",
                                    textColor: Color(0xFF666666),
                                    onClick: () {},
                                    backgroundColor: Color(0xFFEFEFEF),
                                  ),
                                ),
                                Expanded(
                                  child: YmTextButton(
                                    "确认",
                                    textColor: Color(0xFFFFFFFF),
                                    onClick: () {
                                      setState(() {
                                        _showBoxDialog = false;
                                      });
                                    },
                                    backgroundColor: Color(0xFF3446F2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
