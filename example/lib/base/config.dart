import 'package:flutter/material.dart';


///系统主题设置，包括系统默认字体 背景色等
class Config {

  static bool isDebug = true;   //是否是调试模式
  static bool isWeb = true;     //是否是Web运行   【不用修改 Native调用程序自己会判断】
  static bool isTest = false;   //是否是测试环境   【不用修改 Native调用程序自己会判断】

  static String token = "";              //当前Token
  static String userId = "";             //登录用户ID
  static String serverAddress = "http://ymbok.com";

  static String LOGIN_USER_URL =  "/api.php/api/loginPassword/ajax/1";          //登录

  static Future<String> getURL(String path) async {
    return serverAddress + path;
  }

}
