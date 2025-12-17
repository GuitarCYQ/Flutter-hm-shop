import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super (key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _controller = CarouselSliderController(); // 轮播图控制器

  int _currentIndex = 0; // 当前激活的索引

  // 轮播图
  Widget _getSlider () {
    // 在flutter获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;

    // 返回轮播图插件
    // 根据数据渲染的不同的轮播选项
    return CarouselSlider(
      carouselController: _controller, // 轮播图控制器 绑定controller对象，点击指示灯导航时 轮播图会切换到对应的索引
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover, //铺满全屏
          width: screenWidth,
        );
      }), 
      options: CarouselOptions(
        autoPlayAnimationDuration: Duration(seconds: 2), // 自动播放动画时长 2秒
        viewportFraction: 1, // 每个轮播图占满全屏
        autoPlay: true, // 自动播放
        height: 300,
        // 轮播图切换的回调函数，用于拿取当前激活的索引
        onPageChanged: (int index, reason) {
          setState(() {
            _currentIndex = index;
          });
        }
      ));
  }

  // 搜索框
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10), // 内边距10
        child: Container(
          alignment: Alignment.center, // 居中对齐
          padding: EdgeInsets.symmetric(horizontal: 40), // 水平方向内边距40
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.5), // 半透明背景
            borderRadius: BorderRadius.circular(25), // 圆角25px
          ),
          child: Text('搜索...', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  // 指示灯导航
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 在主轴居中
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () { // 点击事件 切换到对应的索引
                _controller.animateToPage(index);
              },
              // AnimatedContainer  动画容器 用于指示灯导航的切换效果
              child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // 动画时长 300毫秒
              height: 6,
              width: index == _currentIndex ? 40 : 20,
              margin: EdgeInsets.symmetric(horizontal: 4), // 水平方向外边距4
              decoration: BoxDecoration( // 装饰器
                // 选中的指示灯背景颜色为白色，未选中的为半透明背景
                color: index == _currentIndex ? Colors.white : Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(
      children: [
        _getSlider(),
        _getSearch(),
        _getDots(),
      ],
    );
    // return Container(
    //   height: 300, // 高度
    //   color: Colors.blue, // 背景颜色
    //   alignment: Alignment.center, // 居中对齐
    //   child: Text("轮播图组件", style:TextStyle(color: Colors.white, fontSize: 20)), // 居中显示
    // );
  }
}