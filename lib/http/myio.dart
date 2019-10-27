import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import '../common/global/global.dart';

class MyIo {
  static String baseUrl = Config.baseUrl;

  static requestGet(url, {params, noTip = false}) async {
    Options option = new Options(method: "get");
    return await requestBase(url, null, option, params: params, noTip: noTip);
  }

  static requestPost(url, {params, noTip = false}) async {
    Options option = new Options(method: "post");
    return await requestBase(url, null, option, params: params, noTip: noTip);
  }

  static requestBase(url, Map<String, String>header, Options option, {params, noTip = false}) async {
    // 判断网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {

    } else if (connectivityResult == ConnectivityResult.wifi) {
      
    } else if (connectivityResult == ConnectivityResult.none){
      return YYResultModel(YYResultErrorEvent(YYResultCode.NETWORK_ERROR, "请检查网络"), false, YYResultCode.NETWORK_ERROR);
    }

    //处理请求头
    Map<String, String> headers = {'token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTA1MjR9.NFbOQlPwU8_RsT3Rdq63aFYB8vqmUEoJ3fdmAGGuXz0'};
    if (header!=null) {
      headers.addAll(header);
    }

    // baseOptions
    var baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 15000,
    );

    //options处理
    if (option != null) {
      option.headers = headers;
    } else{
      option = new Options(method: "get");
      option.headers = headers;
    }

    var dio = new Dio(baseOptions);
    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = YYResultCode.NETWORK_TIMEOUT;
      }
      // debug模式才打印
      if (Config.debug) {
        print('------------请求异常------------');
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + option.headers.toString());
        print('method: ' + option.method);
        print('-------------------------------');
      }
      // 返回错误信息
      return new YYResultModel(YYResultCode.errorHandleFunction(errorResponse.statusCode, error.message, noTip), false, errorResponse.statusCode);
    }

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new YYResultModel(response.data, true, YYResultCode.SUCCESS, headers: response.headers);
      }
    } catch (error) {
      print(error.toString() + url);
      return new YYResultModel(response.data, false, response.statusCode, headers: response.headers);
    }
    return new YYResultModel(YYResultCode.errorHandleFunction(response.statusCode, "", noTip), false, response.statusCode);
  }
}

/// 生成错误信息
class YYResultErrorEvent {
  final int code;

  final String message;

  YYResultErrorEvent(this.code, this.message);
}

/// 生成本地数据格式
class YYResultModel {
  var data;
  bool success;
  int code;
  var headers;

  YYResultModel(this.data, this.success, this.code, {this.headers});
}

/// 本地状态码
class YYResultCode {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  // static final EventBus eventBus = new EventBus();

  static errorHandleFunction(code, message, noTip) {
    if(noTip) {
      return message;
    }
    // eventBus.fire(new YYResultErrorEvent(code, message));
    return message;
  }
}