// 每一个轮播图的具体类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展工厂函数，一般用factory来声明，一般用来创建实例对象，把获取的数据里的参数转换成上面 String xxx这样的，不用我们一个一个手写
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }
}

// flutter必须强制转化，没有隐式转化
