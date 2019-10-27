import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import '../common/global/global.dart';

class Io {
  static String baseUrl = Config.baseUrl;
  static int connectTimeout = Config.connectTimeout;

  /// get请求
  static get(String url, {data}) {
    return _base(url, data, Options(method: "get"));
  }

  /// get请求
  static post(String url, {data}) {
    return _base(url, data, Options(
      method: "post",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
      }
    ));
  }

  /// 请求公用类
  static _base(String url, Map<String, dynamic> data, Options option) async {
    /// 判断网络
    ConnectivityResult connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {

    } else if (connectivityResult == ConnectivityResult.wifi) {
      
    } else if (connectivityResult == ConnectivityResult.none){
      return ResultModel.fail("请检查网络", ResultCode.NETWORK_TIMEOUT);
    }

    /// 公用配置
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
    );

    /// 单独配置
    String token = cache.getString('token');
    Map<String, String> headers = {
      "token": token,
    };
    option.headers.addAll(headers);

    Dio dio = new Dio(baseOptions);
    Response response;
    try {
      if (option.method == 'get') {
        response = await dio.request(url, queryParameters: data, options: option);
      } else {
        response = await dio.request(url, data: data, options: option);
      }
    } catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: ResultCode.UnknownError);
      }

      // 超时
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ResultCode.NETWORK_TIMEOUT;
      }

      print('------------请求异常------------');
      print('请求异常: ' + e.toString());
      print('请求异常url: ' + url);
      print('请求头: ' + option.headers.toString());
      print('method: ' + option.method);
      print('-------------------------------');

      // 返回错误信息
      return ResultModel.fail(e.message, errorResponse.statusCode);
    }

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResultModel.success(response.data, "请求成功");
      }
    } catch (error) {
      print("${response.statusCode} 接口 $url 请求错误：" + error.toString());
      return ResultModel.fail("请求失败", response.statusCode);
    }
    return ResultModel.fail("请求失败", response.statusCode);
  }
}

/// 统一返回格式
class ResultModel {
  var data;
  bool status;
  String msg;
  int code;

  /// 返回类构造函数
  ResultModel(this.status, this.data, this.msg, this.code);

  /// 返回成功命名构造函数
  ResultModel.success(data, msg) {
    this.status = true;
    this.data = data;
    this.msg = msg;
    this.code = 200;
  }

  /// 返回失败命名构造函数
  ResultModel.fail(msg, code, {data}) {
    this.status = false;
    this.data = data;
    this.msg = msg;
    this.code = code;
  }
}

/// 本地状态码
class ResultCode {
  /// 未知错误
  static const UnknownError = -1;

  /// 网络错误
  static const NETWORK_ERROR = 500;

  /// 网络超时
  static const NETWORK_TIMEOUT = 503;

  /// 找不到指定资源
  static const NETWORK_NotFound = 404;

  /// 成功
  static const SUCCESS = 200;
}