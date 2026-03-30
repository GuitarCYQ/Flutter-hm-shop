/// 存放全局常量
class GlobalConstants {
  // static 让他变成静态，可以使用GlobalConstants.xxx来调用
  // const 让他变成常量，不能被修改
  static const String BASE_URL = 'https://meikou-api.itheima.net'; // 基础地址
  static const int TIME_OUT = 10; // 超时时间
  static const String SUCCESS_CODE = '1'; // 成功状态码
  static const String TOKEN_KEY = 'hm_shop_token'; // token持久化的key
}

/// 存放请求地址接口的常量

class HttpConstants {
  // 轮播图
  static const String BANNER_LIST = '/home/banner';
  // 分类
  static const String CATEGORY_LIST = '/home/category/head';
  // 特惠推荐
  static const String PRODUCT_LIST = '/hot/preference';
  // 爆款推荐
  static const String INVOGUE_LIST = '/hot/inVogue';
  // 一站买全
  static const String ONESTOP_LIST = '/hot/oneStop';
  // 推荐列表
  static const String RECOMMEND_LIST = '/home/recommend';
  // 猜你喜欢
  static const String GUESS_LIST = '/home/goods/guessLike';
  //登录
  static const String LOGIN = '/login';
  // 用户信息接口
  static const String USER_PROFILE = '/member/profile';
}
