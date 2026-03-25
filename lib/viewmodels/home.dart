// 构造一个类去定义banner的数据结构
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 从json中解析数据 扩展工厂函数，一般用factory来声明，一般用来创建实例对象，
  // 把获取到的数据通过json解析成 id: '1', imgUrl: 'https://picsum.photos/id/1/200/300'
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }
}

// flutter必须强制转化，没有隐式转化


// 根据json 编写class对象和工厂转化函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({required this.id, required this.name, required this.picture, this.children,});
  // 从json中解析数据 扩展工厂函数，一般用factory来声明，一般用来创建实例对象，
  // 把获取到的数据通过json解析成 id: '1', name: '气质女装', picture: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png', children: [], goods: []
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: json['children'] == null
          ? null
          : (json['children'] as List)
              .map((item) => CategoryItem.formJSON(item as Map<String, dynamic>))
              .toList(),
    );
  }
}