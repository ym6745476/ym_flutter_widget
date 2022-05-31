import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Error/ym_error.dart';
import 'package:ym_flutter_widget/widgets/Loading/ym_loading.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key}) : super(key: key);

  final String title = "Error Page";

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> with SingleNativeStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
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

            isLoading
                ? Positioned(
                    top: appBarHeight,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - appBarHeight,
                    child: YmLoading())
                : Positioned(
                    top: MediaQuery.of(context).padding.top + 56,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - appBarHeight,
                    child: YmError("网络状态不佳", "assets/images/ic_no_data.png")),
          ],
        ),
      ),
    );
  }
}
