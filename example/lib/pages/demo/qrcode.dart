import 'dart:ui';
import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/QrCode/ym_qrcode.dart';

class QRCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> with SingleNativeStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        ///扫码组件
        Positioned(
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: YmQRCode(
              flashImage: ["assets/images/ic_flash_on.png", "assets/images/ic_flash_off.png"],
            ),
          ),
        ),

        ///导航栏
        Positioned(
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: YmAppBar(
              "扫一扫",
              background: [
                const Color(0x00606FFF),
                const Color(0x003446F2),
              ],
              onBackClick: goBack,
              textColor: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
