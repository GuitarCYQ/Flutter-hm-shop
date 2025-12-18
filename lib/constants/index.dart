// 存放全局常量
class GlobalConstants {
  // 基础地址 加上static 会导致属性变成静态的 const 会导致属性变成编译时常量
  static const String BASE_URL = 'https://meikou-api.itheima.net';
  // 超时时间
  static const int TIME_OUT = 10; //秒
  // 业务状态码 成功
  static const String SUCCESS_CODE = '1';
}

// 存放请求地址接的常量
class HttpConstants {
  // 请求地址
  static const String BANNER_LIST = GlobalConstants.BASE_URL + '/home/banner';
}