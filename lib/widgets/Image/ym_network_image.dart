import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../compatible/ym_compatible_ui.dart' if (dart.library.html) 'dart:ui' as ui;
import '../../compatible/ym_compatible_html.dart' if (dart.library.html) 'dart:html' as html;

class YmNetworkImage extends StatelessWidget {

  String url;
  final Size size;
  final Function() onClick;

  /// 图片地址是否跨域
  final bool isCross;
  String chooseIcon;
  String backgroundImage;

  YmNetworkImage({
    required this.url,
    required this.onClick,
    required this.isCross,
    this.size = const Size(40, 40),
    this.chooseIcon = "",
    this.backgroundImage = "",
  });

  @override
  Widget build(BuildContext context) {
    Widget placeView = this.backgroundImage.isNotEmpty ? Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
        ),
      ),
    ) : Container();

    if (kIsWeb && isCross) {
      html.ImageElement imageElement = html.ImageElement();
      imageElement.style.width = "auto";
      imageElement.style.height = "100%";
      imageElement.style.left = "50%";
      imageElement.style.position = "absolute";
      imageElement.style.transform = "translate(-50%,0%)";
      ui.platformViewRegistry.registerViewFactory(
        url, (int _) => imageElement..src = url,
      );
      HtmlElementView imageView = HtmlElementView(viewType: url);

      return Container(
        width: size.width,
        height: size.height,
        child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              url.isNotEmpty ? imageView : placeView,
              chooseIcon.isNotEmpty ? Image.asset(
                chooseIcon,
                fit: BoxFit.fitWidth,
                width: 30,
              ):Container(),
              GestureDetector(
                child: Container(width: size.width, height: size.height, color: Colors.transparent,),
                onTap: onClick,
              ),
            ]
        ),
      );

    } else {
      return Container(
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              url.isNotEmpty ? Image.network(url) : placeView,
              chooseIcon.isNotEmpty ?Image.asset(
                chooseIcon,
                fit: BoxFit.fitWidth,
                width: 30,
              ):Container(),
              GestureDetector(
                child: Container(width: size.width, height: size.height, color: Colors.transparent,),
                onTap: onClick,
              ),

            ]
        )
      );
    }
  }
}