/// 存放全局常量
class GlobalConstants {
  // static 让他变成静态，可以使用GlobalConstants.xxx来调用
  // const 让他变成常量，不能被修改
  static const String BASE_URL = 'https://meikou-api.itheima.net'; // 基础地址
  static const int TIME_OUT = 10; // 超时时间
  static const String SUCCESS_CODE = '1'; // 成功状态码
}

/// 存放请求地址接口的常量

class HttpConstants {
  // 轮播图
  static const String BANNER_LIST = '/home/banner';

  // 分类
  static const String CATEGORY_LIST = '/home/category/head';
}
