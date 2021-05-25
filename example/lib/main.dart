import 'package:example/pages/demo/appbar.dart';
import 'package:example/pages/demo/button.dart';
import 'package:example/pages/demo/cascader.dart';
import 'package:example/pages/demo/http.dart';
import 'package:example/pages/demo/native.dart';
import 'package:example/pages/demo/searchbar.dart';
import 'package:flutter/material.dart';
import 'pages/hello.dart';

void main(){
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
      //home: HelloPage(title: 'Home Page'),
      routes: MyRouter.routes,
      initialRoute: MyRouter.helloPage,   //初始页面路由可代替home
    );
  }

}

class MyRouter {

  //Name 路由的时候都是routeFromFlutter为false  只能用于从Native路由进来
  static final helloPage = '/hello';
  static final nativePage = '/demo/native';
  static final httpPage = '/demo/http';
  static final appbarPage = '/demo/appbar';
  static final searchbarPage = '/demo/searchbar';
  static final buttonPage = '/demo/button';
  static final cascaderPage = '/demo/cascader';

  static final Map<String, WidgetBuilder> routes = {
    helloPage: (ctx) => HelloPage(),
    nativePage: (ctx) => NativePage(),
    httpPage: (ctx) => HttpPage(),
    appbarPage: (ctx) => AppBarPage(),
    searchbarPage: (ctx) => SearchBarPage(),
    buttonPage: (ctx) => ButtonPage(),
    cascaderPage: (ctx) => CascaderPage(),
  };
}


