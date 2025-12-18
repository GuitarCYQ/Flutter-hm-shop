// 基础DIO 进行二次封装

import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class Diorequest {
  final _dio = Dio(); // dio请求对象
  // 配置地址拦截器
  DioRequest() {
    // ..代表连续赋值
    _dio.options
     ..baseUrl = GlobalConstants.BASE_URL
     ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
     ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
     ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);

     // 拦截器
     _addInterceptor();
  }

  void _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) {
        handler.next(request);
      },
      onResponse: (response, handler) {
        // http 状态码 200 ，300
        if(response.statusCode! >= 200 && response.statusCode! < 300) {
          // 对响应数据进行处理
          handler.next(response);
          return;
        }
        handler.reject(DioException(requestOptions: response.requestOptions)); // 拒绝响应
      },
      onError: (error, handler) {
        handler.reject(error);
      }
    ));
  }

  // 封装get请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }
  
  // 进一步解构响应数据
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data =res.data as Map<String, dynamic>; // data 才是真实的接口返回数据
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        // 才认定http状态和业务状态均正常，就可以正常通过了
        return data['result'];
      }
      // 状态不对 抛出异常
      throw Exception(data['msg'] ?? '加载数据异常');
    } catch (e) {
      throw Exception(e);
    }
  }

}

// 单例对象
final dioRequest = Diorequest();