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
  CarouselSliderController _controller =
      CarouselSliderController(); // 控制轮播图跳转控制器
  int _currentIndex = 0;

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
        carouselController: _controller, // 绑定controller对象 让导航跟轮播图片一起绑定
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
          // 监听轮播图切换
          onPageChanged: (int index, reason) {
            _currentIndex = index;
            setState(() {});
          },
        ),
      );
    }

    // 搜索
    Widget _getSearch() {
      return Positioned(
        top: 10,
        left: 0,
        right: 0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              '搜索...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      );
    }

    // 轮播图导航
    Widget _getDots() {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.bannerList.length, (int index) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(index);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 6,
                  width: index == _currentIndex ? 40 : 20,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index == _currentIndex
                        ? Colors.white
                        : Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }

    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
