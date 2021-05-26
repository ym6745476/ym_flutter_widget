import 'package:example/pages/demo/appbar.dart';
import 'package:example/pages/demo/button.dart';
import 'package:example/pages/demo/cascader.dart';
import 'package:example/pages/demo/dialog.dart';
import 'package:example/pages/demo/empty.dart';
import 'package:example/pages/demo/error.dart';
import 'package:example/pages/demo/html.dart';
import 'package:example/pages/demo/http.dart';
import 'package:example/pages/demo/image.dart';
import 'package:example/pages/demo/loading.dart';
import 'package:example/pages/demo/native.dart';
import 'package:example/pages/demo/searchbar.dart';
import 'package:example/pages/demo/textfield.dart';
import 'package:example/pages/demo/toast.dart';
import 'package:example/pages/demo/video.dart';
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
  static final textFieldPage = '/demo/textfield';
  static final dialogPage = '/demo/dialog';
  static final toastPage = '/demo/toast';
  static final loadingPage = '/demo/loading';
  static final emptyPage = '/demo/empty';
  static final errorPage = '/demo/error';
  static final htmlPage = '/demo/html';
  static final imagePage = '/demo/image';
  static final videoPage = '/demo/video';

  static final Map<String, WidgetBuilder> routes = {
    helloPage: (ctx) => HelloPage(),
    nativePage: (ctx) => NativePage(),
    httpPage: (ctx) => HttpPage(),
    appbarPage: (ctx) => AppBarPage(),
    searchbarPage: (ctx) => SearchBarPage(),
    buttonPage: (ctx) => ButtonPage(),
    cascaderPage: (ctx) => CascaderPage(),
    textFieldPage: (ctx) => TextFieldPage(),
    dialogPage: (ctx) => DialogPage(),
    toastPage: (ctx) => ToastPage(),
    loadingPage: (ctx) => LoadingPage(),
    emptyPage: (ctx) => EmptyPage(),
    errorPage: (ctx) => ErrorPage(),
    htmlPage: (ctx) => HtmlPage(),
    imagePage: (ctx) => ImagePage(),
    videoPage: (ctx) => VideoPage(),
  };
}


