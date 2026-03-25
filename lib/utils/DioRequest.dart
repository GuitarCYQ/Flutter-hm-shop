// 基于Dio进行二次封装

import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio(); // dio请求对象
  // 构造函数
  DioRequest() {
    // 连续赋值
    _dio.options
      ..baseUrl = GlobalConstants
          .BASE_URL // 请求地址
      ..connectTimeout =
          Duration(seconds: GlobalConstants.TIME_OUT) // 连接超时
      ..sendTimeout =
          Duration(seconds: GlobalConstants.TIME_OUT) // 发送超时
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT); // 接收超时
    // 拦截器
    _addInterceptor();
  }

  // 添加拦截器
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handle) {
          handle.next(request); // 放行
        },
        onResponse: (response, handler) {
          // http 状态码 200 300
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          // 拦截处理
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }

  // 封装get请求
  Future<dynamic> get(String url, Map<String, dynamic>? params) {
    // 传参给_handleResponse()进一步处理返回的数据
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; // data 才是我们真是的接口数据
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        // code == 定义好的SUCCESS_CODE，才认定http状态和业务状态均正常，就可以正常的放行
        return data['result'];
      }
      // 抛出异常
      throw Exception(data['message'] ?? '加载数据异常');
    } catch (e) {
      throw Exception(e);
    }
  }
}

// 单例对象
final dioRequest = DioRequest();


// dio请求工具发出请求 返回的数据 Response<dynamic>.data
// 把所有的接口的data结构出来 拿到真正的数据 判断业务状态码是否 = 1，上面的response.statusCode是请求状态码 跟业务状态码是分开的