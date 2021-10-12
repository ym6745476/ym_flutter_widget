import 'package:example/pages/demo/appbar.dart';
import 'package:example/pages/demo/button.dart';
import 'package:example/pages/demo/cascader.dart';
import 'package:example/pages/demo/checkbutton.dart';
import 'package:example/pages/demo/datetimepicker.dart';
import 'package:example/pages/demo/dialog.dart';
import 'package:example/pages/demo/empty.dart';
import 'package:example/pages/demo/error.dart';
import 'package:example/pages/demo/html.dart';
import 'package:example/pages/demo/http.dart';
import 'package:example/pages/demo/image.dart';
import 'package:example/pages/demo/listview.dart';
import 'package:example/pages/demo/loading.dart';
import 'package:example/pages/demo/native.dart';
import 'package:example/pages/demo/pull_refresh.dart';
import 'package:example/pages/demo/qrcode.dart';
import 'package:example/pages/demo/searchbar.dart';
import 'package:example/pages/demo/stream.dart';
import 'package:example/pages/demo/tabbutton.dart';
import 'package:example/pages/demo/tabpageview.dart';
import 'package:example/pages/demo/textfield.dart';
import 'package:example/pages/demo/toast.dart';
import 'package:example/pages/demo/video.dart';
import 'package:example/pages/hello.dart';
import 'package:flutter/cupertino.dart';
class MyRouter {
  /// Name方式路由页面
  static final helloPage = '/';
  static final nativePage = '/demo/native';
  static final httpPage = '/demo/http';
  static final appbarPage = '/demo/appbar';
  static final searchbarPage = '/demo/searchbar';
  static final buttonPage = '/demo/button';
  static final tabButtonPage = '/demo/tabbutton';
  static final checkButtonPage = '/demo/checkbutton';
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
  static final tabViewPage = '/demo/tabview';
  static final listViewPage = '/demo/listview';
  static final qrCodePage = '/demo/qrcode';
  static final dateTimePickerPage = '/demo/datetimepicker';
  static final pullRefreshPage = '/demo/pull_refresh';
  static final streamPage = '/demo/stream';

  ///
  /// 路由代码
  /// Navigator.of(context).pushNamed('/demo/native', arguments: {'flutter': true});
  ///
  static final Map<String, WidgetBuilder> routes = {
    helloPage: (ctx) => HelloPage(),
    nativePage: (ctx) => NativePage(),
    httpPage: (ctx) => HttpPage(),
    appbarPage: (ctx) => AppBarPage(),
    searchbarPage: (ctx) => SearchBarPage(),
    buttonPage: (ctx) => ButtonPage(),
    tabButtonPage: (ctx) => TabButtonPage(),
    checkButtonPage: (ctx) => CheckButtonPage(),
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
    tabViewPage: (ctx) => TabPageViewPage(),
    listViewPage: (ctx) => ListViewPage(),
    qrCodePage: (ctx) => QRCodePage(),
    dateTimePickerPage: (ctx) => DateTimePickerPage(),
    pullRefreshPage: (ctx) => PullRefreshPage(),
    streamPage: (ctx) => StreamPage(),
  };
}