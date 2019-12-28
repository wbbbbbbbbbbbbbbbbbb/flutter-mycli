import 'dart:io';

import 'package:dio/dio.dart';
import '../../common/global/global.config.dart';
import '../../common/global/global.sugar.dart';

class Io {
  static String baseUrl = Config.baseUrl;
  static int connectTimeout = Config.connectTimeout;

  /// get请求
  static get(
    String url, {
    Map<String, dynamic> data,
    bool debug = false,
  }) {
    return _base(
      url,
      Options(method: "get"),
      data: data,
    );
  }

  /// get请求
  static post(
    String url, {
    Map<String, dynamic> data,
    bool debug = false,
  }) {
    return _base(
      url,
      Options(
        method: "post",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
        },
      ),
      data: data,
    );
  }

  /// 文件上传
  static updateFile(String url, File file,{String size,Function monitor}) async {
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.from({
      "file": UploadFileInfo(File(path), name),
      'imgsize': size
    });
    Dio dio = Dio();
    Response respone = await dio.post(
      baseUrl + url,
      data: formData,
      onSendProgress:monitor
    );
    if (respone.statusCode == 200) {
      print('上传成功');
    } else{
      throw Exception('后端接口异常');
    }
    return respone;
  }

  /// 请求公用类
  static _base(
    String url,
    Options option, {
    Map<String, dynamic> data,
    bool debug = false,
  }) async {
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
      switch (option.method) {
        case 'GET':
        case 'get':
          response = await dio.request(url, queryParameters: data, options: option);
          break;
        case 'POST':
        case 'post':
          response = await dio.request(url, data: data, options: option);
          break;
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

      switch (errorResponse.statusCode) {
        case -1:
          showToast("未知错误");
          break;
        case 404:
          showToast("找不到指定资源");
          break;
        case 500:
          showToast("服务器异常");
          break;
        case 502:
          showToast("网络异常");
          break;
        case 503:
          showToast("网络超时");
          break;
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

    if (debug) {
      print('------------请求信息------------');
      print('请求url: ' + baseUrl + url);
      print('请求状态码: ' + response.statusCode.toString());
      print('请求头: ' + option.headers.toString());
      print('请求参数: ' + data.toString());
      print('请求方法: ' + option.method);
      print('请求结果: ${response.data}');
      print('-------------------------------');
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResultModel.fromJson(response.data);
    } else {
      return ResultModel.fail("请求失败", response.statusCode);
    }
  }
}

/// 统一返回格式
class ResultModel {
  dynamic data;
  int status;
  String msg;
  int code;

  /// 返回类构造函数
  ResultModel(this.status, this.data, this.msg, this.code);

  ResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    msg = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['msg'] = this.msg;
    data['code'] = this.code;
    return data;
  }

  /// 返回成功命名构造函数
  ResultModel.success(data, msg) {
    this.status = 1;
    this.data = data;
    this.msg = msg;
    this.code = 200;
  }

  /// 返回失败命名构造函数
  ResultModel.fail(msg, code, {data}) {
    this.status = 0;
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
