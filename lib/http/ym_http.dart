import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ym_flutter_widget/http/ym_form_data.dart';

/// 网络请求管理类
class YmHttp {
  // 单例模式
  static var _instance;

  //工厂构造函数
  factory YmHttp() => _getInstance();

  // 私有构造函数
  YmHttp._internal() {
    // 初始化
    init();
  }

  // 静态私有
  static YmHttp _getInstance() {
    if (_instance == null) {
      _instance = new YmHttp._internal();
    }
    return _instance;
  }

  //Dio
  late Dio _dio;

  ///构造
  init() {
    print('YmHttp init~');
    _dio = new Dio();

    //请求header的配置
    _dio.options.headers = {};

    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;

    _dio.interceptors.add(LogInterceptor(responseBody: false)); //是否开启请求日志
    _dio.interceptors.add(CookieManager(CookieJar())); //缓存相关类
  }

  /// 设置公共请求头
  setHeader(Map<String, String> params) {
    _dio.options.headers.addAll(params);
    print('YmHttp 设置Header: ' + _dio.options.headers.toString());
  }

  ///get请求
  get(String url, Map<String, dynamic> params,
      {required Function success, required Function error, required Function complete}) async {
    _requestHttp(url, "get", params, success, error, complete);
  }

  ///post json请求
  post(String url, Map<String, dynamic> params,
      {required Function success, required Function error, required Function complete}) async {
    _requestHttp(url, "post", params, success, error, complete);
  }

  ///post请求
  postForm(String url, Map<String, dynamic> params,
      {required Function success, required Function error, required Function complete}) async {
    _requestHttp(url, "postForm", params, success, error, complete);
  }

  ///上传文件 web
  postFile(String url,Map<String, dynamic> params,String filePath,Uint8List fileBytes,Stream stream,
      {required Function success, required Function error, required Function complete}) async {
    _postFile(url, params,filePath,fileBytes ,stream,success, error, complete);
  }

  ///上传文件 web
  _postFile(String url,Map<String, dynamic> params,String filePath,Uint8List fileBytes,Stream stream,
      Function successCallBack,Function errorCallBack, Function completeCallBack) async {

    late Response response;
    try {
      print('请求Header: ' + _dio.options.headers.toString());

      var byteStream =  new http.ByteStream(stream.cast());
      int length = fileBytes.length;
      print("filePath：" + filePath);
      String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
      if(fileName.indexOf(".")==-1){
        /// 查mimetype表进行设置
        if(params["mediaSubType"] == "jpeg"){
          fileName += ".jpg";
        }else{
          fileName += "." + params["mediaSubType"] ;
        }
      }

      http.MultipartFile file = new http.MultipartFile(
          "file",
          byteStream,
          length,
          filename: fileName,
          contentType:MediaType(params["mediaType"], params["mediaSubType"]), //mediaType=image,mediaSubType=jpeg
      );
      params.remove("mediaType");
      params.remove("mediaSubType");
      params["file"] = file;

      print("参数：" + params.toString());

      response = await _dio.post(url, data: YmFormData.fromMap(params));

      if (response.data is String) {
        print("请求成功：" + response.data);
        successCallBack(json.decode(response.data));
      } else {
        String responseStr = json.encode(response.data);
        print("请求成功：" + responseStr);
        successCallBack(response.data);
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
      } else if (error.type == DioErrorType.other) {
        errorMessage = "网络不稳定";
      }

      if (error.response != null) {
        String dataStr = json.encode(error.response!.data);
        print("Http请求出错：" + dataStr);
        if(error.response!.statusCode == 502){
          errorCallBack({'errorCode': 502, 'errorMessage': "服务器连接失败"});
        }else{
          Map<String, dynamic> dataMap = json.decode(dataStr);
          errorCallBack({'errorCode': dataMap['status'], 'errorMessage': dataMap['message'].toString()});
        }

      } else {
        errorCallBack({'errorCode': 600, 'errorMessage': errorMessage});
      }
    } finally {
      completeCallBack();
    }
  }

  ///_requestHttp
  _requestHttp(String url, String method, Map<String, dynamic> params, Function successCallBack, Function errorCallBack,
      Function completeCallBack) async {
    late Response response;
    try {
      print('请求Header: ' + _dio.options.headers.toString());

      if(params.toString().length > 600){
        print('请求参数1-1: ' + params.toString().substring(0,600));
        if(params.toString().length > 1200){
          print('请求参数1-2: ' + params.toString().substring(600,1200));
          print('请求参数1-3: ' + params.toString().substring(1200));
        }else{
          print('请求参数1-2: ' + params.toString().substring(600));
        }
      }else{
        print('请求参数: ' + params.toString());
      }

      if (method == 'get') {
        if (params.length > 0) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if (method == 'post') {
        if (params.length > 0) {
          response = await _dio.post(url, data: params);
        } else {
          response = await _dio.post(url);
        }
      } else if (method == 'postForm') {
        if (params.length > 0) {
          params.forEach((key, value) {
            if (value is File) {
              String fileName = value.path.substring(value.path.lastIndexOf("/") + 1);
              if(fileName.indexOf(".")==-1){
                fileName += ".unknown";
              }
              print('fileName: ' + fileName);
              // 用http.MultipartFile 兼容web 上传图片用postFile函数
              MultipartFile file = MultipartFile.fromFileSync(value.path,filename: fileName);
              params[key] = file;
            }
          });
          print("提交参数：" + params.toString());
          YmFormData formData =  YmFormData.fromMap(params);
          response = await _dio.post(url, data: formData);
        } else {
          response = await _dio.post(url);
        }
      }

      if (response.data is String) {
        print("请求成功：" + response.data);
        successCallBack(json.decode(response.data));
      } else {
        String responseStr = json.encode(response.data);
        print("请求成功：" + responseStr);
        successCallBack(response.data);
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
      } else if (error.type == DioErrorType.other) {
        errorMessage = "网络不稳定";
      }

      if (error.response != null) {
        String dataStr = json.encode(error.response!.data);
        print("Http请求出错：" + dataStr);
        if(error.response!.statusCode == 502){
          errorCallBack({'errorCode': 502, 'errorMessage': "服务器连接失败"});
        }else{
          Map<String, dynamic> dataMap = json.decode(dataStr);
          errorCallBack({'errorCode': dataMap['status'], 'errorMessage': dataMap['message'].toString()});
        }

      } else {
        errorCallBack({'errorCode': 600, 'errorMessage': errorMessage});
      }
    } finally {
      completeCallBack();
    }
  }

  cancelRequest(){
    try {
      _dio.close(force: true);
    }on DioError catch (error) {
    }
  }

}
