import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:convert';

/*
 * 网络请求管理类
 */
class YmHttp {

  //写一个单例
  static var _instance;

  //Dio
  Dio dio = new Dio();

  ///单例
  static YmHttp getInstance() {
    if (_instance == null) {
      _instance = YmHttp();
    }
    return _instance;
  }

  ///构造
  YmHttp() {

    //请求header的配置
    dio.options.headers = {

    };

    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;

    dio.interceptors.add(LogInterceptor(responseBody:false));           //是否开启请求日志
    dio.interceptors.add(CookieManager(CookieJar()));                   //缓存相关类
  }

  /// 设置公共请求头
  setHeader(Map<String, String> params) async {
      dio.options.headers.addAll(params);
  }

  ///get请求
  get(String url, Map<String, dynamic> params, Function successCallBack,Function errorCallBack) async {
     _requestHttp(url, "get", params, successCallBack,errorCallBack);
  }

  ///post json请求
  post(String url, Map<String, dynamic> params, Function successCallBack, Function errorCallBack) async {
    _requestHttp(url, "post", params, successCallBack,errorCallBack);
  }

  ///post请求
  postForm(String url, Map<String, dynamic> params, Function successCallBack, Function errorCallBack) async {
    _requestHttp(url, "postForm", params, successCallBack,errorCallBack);
  }

  ///_requestHttp
  _requestHttp(String url,String method, Map<String, dynamic> params,Function successCallBack, Function errorCallBack) async {
    late Response response;
    try {

      print('请求Header: ' + dio.options.headers.toString());
      print('请求参数: ' + params.toString());
      if (method == 'get') {
        if (params.length > 0) {
          response = await dio.get(url,queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      }else if (method == 'post') {
        if (params.length > 0) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }else if (method == 'postForm') {
        if (params.length > 0) {
          response = await dio.post(url, data: FormData.fromMap(params));
        } else {
          response = await dio.post(url);
        }
      }

      if(response.data is String){
        print("请求成功：" + response.data);
        //json字符串转换成Map
        Map<String, dynamic> responseMap = json.decode(response.data);
        successCallBack(responseMap);
      }else{
        String responseStr = json.encode(response.data);
        print("请求成功：" + responseStr);
        Map<String, dynamic> responseMap = json.decode(responseStr);
        successCallBack(responseMap);
      }

    } on DioError catch (error) {


      // 请求错误处理
      String errorMessage = error.message;
      // 请求超时
      if (error.type == DioErrorType.connectTimeout) {
        errorMessage = "请求超时";
      }
      // 服务器错误
      else if (error.type == DioErrorType.receiveTimeout) {
        errorMessage = "接收超时";
      }
      else if (error.type == DioErrorType.other) {
        errorMessage = "网络不稳定";
      }

      if (error.response != null) {
        String dataStr = json.encode(error.response!.data);
        Map<String, dynamic> dataMap = json.decode(dataStr);
        errorCallBack('错误码：' + dataMap['errorCode'].toString() + '，' + response.data.toString());
      }else{
        errorCallBack(errorMessage);
      }

    }

  }

}
