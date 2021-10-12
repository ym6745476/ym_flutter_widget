
import 'package:flutter/material.dart';

import 'my_router.dart';

///
/// 全部Widget的示例代码
/// Pub没法显示图片，所以请到github查看演示效果
/// https://github.com/ym6745476/ym_flutter_widget
///
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ym Flutter Widget',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      /// home: HelloPage(title: 'Home Page'),
      routes: MyRouter.routes,
      initialRoute: MyRouter.helloPage, //初始页面路由可代替home
    );
  }
}

