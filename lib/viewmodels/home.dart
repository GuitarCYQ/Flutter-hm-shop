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
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
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
                .map(
                  (item) => CategoryItem.formJSON(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐 - 商品项
class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'] ?? 0,
    );
  }
}

// 特惠推荐 - 商品列表
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List)
          .map((item) => GoodsItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 特惠推荐 - 子分类
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.formJSON(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: GoodsItems.formJSON(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

// 特惠推荐 - 结果
class SpecialRecemmendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecemmendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialRecemmendResult.formJSON(Map<String, dynamic> json) {
    return SpecialRecemmendResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List? ?? [])
          .map((item) => SubType.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 推荐类型
class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  // 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: '');
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      picture: json['picture']?.toString() ?? '',
      orderNum: int.tryParse(json['orderNum']?.toString() ?? '0') ?? 0,
      payCount: int.tryParse(json['payCount']?.toString() ?? '0') ?? 0,
    );
  }
}

// 猜你喜欢
// 1.请求地址有
// 2.请求类型是GoodsItems类型 => items => List<GoodsItem>
// 3.HmMoreList要的是 List<GoodDetailItem> 类型 实际是 List<GoodsItem>

class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsDetailsItems.formJSON(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List)
          .map((item) => GoodDetailItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}


