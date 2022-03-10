import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../compatible/ym_compatible_ui.dart' if (dart.library.html) 'dart:ui' as ui;
import '../../compatible/ym_compatible_html.dart' if (dart.library.html) 'dart:html' as html;

class YmNetworkImage extends StatelessWidget {

  String url;
  final Size size;
  final Function() onClick;

  YmNetworkImage({
    required this.url,
    required this.onClick,
    this.size = const Size(40, 40),
  });

  @override
  Widget build(BuildContext context) {

    if(kIsWeb){
      html.ImageElement imageElement = html.ImageElement();
      ui.platformViewRegistry.registerViewFactory(
        url, (int _) => imageElement..src = url,
      );
      return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            HtmlElementView(viewType: url),
            GestureDetector(
              child: Container(width: size.width,height: size.height,color: Colors.transparent,),
              onTap: onClick,
            )
          ]
      );
    }else{
      return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.network(url),
            GestureDetector(
              child: Container(width: size.width,height: size.height,color: Colors.transparent,),
              onTap: onClick,
            )
          ]
      );
    }
  }
}