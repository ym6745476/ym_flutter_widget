import 'package:flutter/material.dart';

///系统主题设置，包括系统默认字体 背景色等
class Config {
  static bool isDebug = false; //是否是调试模式        【打包APP时改为false】
  static bool isNative = false; //是否是原生框架里运行   【不用修改 Native调用程序自己会判断，值对APP没影响】
  static bool isTest = false; //是否是测试环境        【不用修改 Native调用程序自己会判断】

  static String appBarHeight = ""; //导航栏+状态栏总高度

  static String token = ""; //当前Token
  static String userId = ""; //登录用户ID
  static String serverAddress = "https://ymbok.com"; //web需要在同一个域名下才能访问接口

  static const String LOGIN_PASSWORD_URL = "/api.php/api/loginPassword/ajax/1"; //登录

  static Future<String> getURL(String path) async {
    return serverAddress + path;
  }
}
