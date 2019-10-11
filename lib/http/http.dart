import 'package:dio/dio.dart';

import '../common/global/global.dart'; //用于配置公用常量

class Http {
  static Dio _dio;
  BaseOptions _options;

  // 构造函数
  Http() {
    _initHttp();
  }

  // 初始化http
  _initHttp() {
    // 初始化 Options
    _options = BaseOptions(
      baseUrl: Config.baseUrl,
      connectTimeout: Config.connectTimeout,
      receiveTimeout: Config.receiveTimeout,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
      }
    );
    _dio = new Dio(_options);

    // 拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      //发送请求拦截处理，例如：添加token使用
      onRequest: (RequestOptions options) {
        // 获取本地token
        String token = cache.getString('token');
        if (token == null) {
          // print("无token，自动获取token中... 并没有，这个功能是假的");
          // _dio.lock();
          // token = '123123123123';
          // _dio.unlock();
          showToast("请先登录");
        } else {
          options.headers["token"] = token;
        }
        return options;
      },

      //请求成功拦截
      onResponse: (Response response) {
        switch (response.statusCode) {
          case 404:
            showToast("请求错误");
            break;
          case 500:
            showToast("服务器错误");
            break;
        }
        return response;
      },

      //请求失败拦截
      onError: (DioError e) {
        if (Config.debug) {
          showToast("服务器请求超时：$e");
        } else {
          showToast("服务器请求超时");
        }
        return e;
      },
    ));
  }

  // get 请求封装
  Future get(url, {data}) async {
    try {
      Response response = await _dio.get(
        url,
        queryParameters: data ?? {},
      );
      return response.data;
    } on DioError catch (e) {
      if (Config.debug) {
        showToast("$url 请求发生错误：$e");
      } else {
        showToast("服务器请求超时");
      }
    }
  }

  // post请求封装
  Future post(url, {data}) async {
    try {
      Response response = await _dio.post(
        url,
        data: data ?? {},
      );
      return response.data;
    } on DioError catch (e) {
      if (Config.debug) {
        showToast("$url 请求发生错误：$e");
      } else {
        showToast("服务器请求超时");
      }
    }
  }

  // get原型类
  dioGet(url, {data}) async {
    Response response = await _dio.get(url, queryParameters: data ?? {});
    return response;
  }

  // post原型类
  dioPost(url, {data}) async {
    Response response = await _dio.post(url, data: data ?? {});
    return response;
  }
}
