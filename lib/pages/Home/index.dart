import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图数据
  List<BannerItem> _bannerList = [];
  // 分类数据
  List<CategoryItem> _categoryList = [];

  List<Widget> _getScrollChildren() {
    return [
      // 包裹普通Widget的sliver家族的组件
      // 轮播图组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      // 间隔
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 分类组件
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      // 间隔
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 推荐组件
      SliverToBoxAdapter(child: HmSuggestion()),
      // 间隔
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 爆款组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      // 间隔
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 无限滚动
      HmMoreList(),
    ];
  }

  @override
  void initState() {
    super.initState();
    // 初始化轮播图数据
    _getBannerList();
    // 初始化分类数据
    _getCategoryList();
  }

  // 调用api/home里的getBannerListAPI方法，获取轮播图数据
  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  // 调用api/home里的getCategoryListAPI方法，获取分类数据
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren()); // 内容必须是sliver家族
  }
}
