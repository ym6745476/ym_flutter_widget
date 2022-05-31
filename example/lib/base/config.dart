import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/compatible/ym_constants.dart';
import 'package:ym_flutter_widget/compatible/ym_compatible_io.dart' if (dart.library.html) 'dart:io' as io;
///系统主题设置，包括系统默认字体 背景色等
class Config {

  static bool isDebug = kDebugMode ? true : false; //是否是调试模式
  static YmPlatform platform =
  kIsWeb ? YmPlatform.web : (io.Platform.isAndroid ? YmPlatform.android : YmPlatform.ios); //自动判断平台

  static String token = ""; //当前Token
  static String userId = ""; //登录用户ID
  static String serverAddress = "https://ymbok.com"; //web需要在同一个域名下才能访问接口

  static const String LOGIN_PASSWORD_URL = "/api.php/api/loginPassword/ajax/1"; //登录

  static Future<String> getURL(String path) async {
    return serverAddress + path;
  }
}
