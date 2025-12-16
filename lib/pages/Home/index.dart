import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 获取滚动容器的内容
  List<Widget> _getScrollChildren () {
    return [
      // 轮播图组件 里面调用HmSlider组件
      SliverToBoxAdapter(child: HmSlider()), 
      // 间隙 有一个10px的间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // ListView 横向滚动组件 里面调用HmCategory组件
      SliverToBoxAdapter(child: HmCategory()),
       // 间隙 有一个10px的间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 推荐组件 里面调用HmSuggestion组件
      SliverToBoxAdapter(child: HmSuggestion()),
      // 间隙 有一个10px的间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 爆款推荐，并且用Flex布局 实现左右两个组件，每个组件宽度相等
      SliverToBoxAdapter(
        // Padding 给组件一个内边距 两边可以留白
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child:HmHot()),
              SizedBox(width: 10),
              Expanded(child:HmHot())
            ],
          ),
        ),
      ),
      
      // 间隙 有一个10px的间隙
      SliverToBoxAdapter(child: SizedBox(height: 10)),



      // 无限滚动列表
      HmMoreList(), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren()); // 滚动组件 sliver家族内容
  }
}