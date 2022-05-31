import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_router.dart';
import 'package:ym_flutter_widget/widgets/Image/ym_image_viewer.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key? key}) : super(key: key);

  final String title = "Image";

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> with SingleNativeStateMixin {

  @override
  void initState() {
    super.initState();
  }

  void _itemOnClick(String path) {
    Navigator.push(context, YmDialogRouter(YmImageViewer(context, path, false)));
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
                    GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "https://ymbok.com/static/ym_flutter_widget/screenshot/pic2.png",
                              fit: BoxFit.fitWidth,
                              width: (MediaQuery.of(context).size.width - 30) / 3,
                            ),
                          ],
                        ),
                        onTap: () {
                          this._itemOnClick("https://ymbok.com/static/ym_flutter_widget/screenshot/pic2.png");
                        }),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
