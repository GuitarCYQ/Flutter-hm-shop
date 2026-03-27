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
  // 特惠推荐数据
  SpecialRecemmendResult _specialRecommendResult = SpecialRecemmendResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 爆款推荐
  SpecialRecemmendResult _inVogueResult = SpecialRecemmendResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 一站全买
  SpecialRecemmendResult _oneStopResult = SpecialRecemmendResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

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
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      // 间隔
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 爆款组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: 'hot'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: 'step'),
              ),
            ],
          ),
        ),
      ),
      // 间隔
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 无限滚动
      HmMoreList(recommendList: _recommendList),
    ];
  }

  // 调用api/home里的getBannerListAPI方法，获取轮播图数据
  void _getBannerList() async {
    _bannerList = await getBannerListAPI({});
    setState(() {});
  }

  // 调用api/home里的getCategoryListAPI方法，获取分类数据
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI({});
    setState(() {});
  }

  // 调用api/home里的getProductListAPI方法，获取特惠推荐数据
  void _getProductList() async {
    _specialRecommendResult = await getProductListAPI({});
    setState(() {});
  }

  // 调用api/home里的getInVogueAPI方法，获取爆款推荐
  void _getInvogueList() async {
    _inVogueResult = await getInVogueListAPI({});
    setState(() {});
  }

  // 调用api/home里的getOneStopListAPI方法，获取一站全买
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI({});
    setState(() {});
  }

  // 定义页码
  int _page = 1;
  // 同时只能加载一个请求
  bool _isLoading = false;
  // 是否还有下一页
  bool _hasMore = true;
  // 调用api/home里的getRecommendListAPI方法，获取推荐列表
  void _getRecommendList() async {
    // 当已经有请求在加载 或者 已经没有下一页了，就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true; // 占住位置，避免重复请求
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; // 松开位置
    setState(() {});

    // 如果你给我的数据 小于 每次要的数据，就认为没有下一页了
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }

    _page++; // 下一页
  }

  @override
  void initState() {
    super.initState();
    // 初始化轮播图数据
    _getBannerList();
    // 初始化分类数据
    _getCategoryList();
    // 初始化特惠推荐数据
    _getProductList();
    // 初始化爆款推荐数据
    _getInvogueList();
    // 获取一站全买数据
    _getOneStopList();
    // 获取推荐列表数据
    _getRecommendList();
    //监听滚动到底部的事件
    _registerEvent();
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      // 滚动的距离pixels 滚动底部的最大距离 maxScrollExtent
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // print('到底了！');
        // 加载下一页数据
        _getRecommendList();
      }
    });
  }

  // CustomScrollView事件控制器controller
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller, // 控制器 可以用于监听滚动事件
      slivers: _getScrollChildren(),
    ); // 内容必须是sliver家族
  }
}
