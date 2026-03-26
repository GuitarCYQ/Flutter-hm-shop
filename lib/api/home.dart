// 封装一个api 目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

// 获取banner列表
Future<List<BannerItem>> getBannerListAPI() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.BANNER_LIST, {})) as List).map((
    item,
  ) {
    return BannerItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}


// 获取分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST, {})) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

// 获取特惠推荐列表 
// 这里直接使用SpecialRecemmendResult结构，是因为在viewmodels/home.dart中SpecialRecemmendResult才是最终的结果，直接使用它就行
Future<SpecialRecemmendResult> getProductListAPI() async {
  // 返回请求
  return SpecialRecemmendResult.formJSON(await dioRequest.get(HttpConstants.PRODUCT_LIST, {}));
}
