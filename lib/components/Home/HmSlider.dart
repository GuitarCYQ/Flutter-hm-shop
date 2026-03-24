import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _getSlider() {
      // 在Flutter 中获取屏幕宽度的方法
      final double screenWidth = MediaQuery.of(context).size.width; // 屏幕宽度

      // 返回轮播图插件
      // 根据数据渲染的不同的轮播选项
      return CarouselSlider(
        items: List.generate(widget.bannerList.length, (int index) {
          return Image.network(
            widget.bannerList[index].imgUrl,
            fit: BoxFit.cover, // 图片全覆盖
            width: screenWidth, // 获取了屏幕的宽度
          );
        }),
        options: CarouselOptions(
          viewportFraction: 1, // 1：轮播图片占满全屏
          autoPlay: true, // 自动播放
          height: 300, // 高度
          autoPlayInterval: Duration(seconds: 5), // 轮播自动播放间隔时间
        ),
      );
    }

    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider()]);
  }
}
