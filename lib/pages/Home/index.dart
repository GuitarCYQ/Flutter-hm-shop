import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/Toastutils.dart';
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
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI({});
  }

  // 调用api/home里的getCategoryListAPI方法，获取分类数据
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI({});
  }

  // 调用api/home里的getProductListAPI方法，获取特惠推荐数据
  Future<void> _getProductList() async {
    _specialRecommendResult = await getProductListAPI({});
  }

  // 调用api/home里的getInVogueAPI方法，获取爆款推荐
  Future<void> _getInvogueList() async {
    _inVogueResult = await getInVogueListAPI({});
  }

  // 调用api/home里的getOneStopListAPI方法，获取一站全买
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI({});
  }

  // 定义页码
  int _page = 1;
  // 同时只能加载一个请求
  bool _isLoading = false;
  // 是否还有下一页
  bool _hasMore = true;
  // 调用api/home里的getRecommendListAPI方法，获取推荐列表
  Future<void> _getRecommendList() async {
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
    // // 初始化轮播图数据
    // _getBannerList();
    // // 初始化分类数据
    // _getCategoryList();
    // // 初始化特惠推荐数据
    // _getProductList();
    // // 初始化爆款推荐数据
    // _getInvogueList();
    // // 获取一站全买数据
    // _getOneStopList();
    // // 获取推荐列表数据
    // _getRecommendList();

    //监听滚动到底部的事件
    _registerEvent();

    // initState => build => 下拉刷新组件 => 才可以操作
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
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

  // 下拉刷新方法
  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getInvogueList();
    await _getOneStopList();
    await _getRecommendList();
    // 获取数据成功，刷新成功
    ToastUtils.showToast(context, '刷新成功');
    _paddingTop = 0;
    setState(() {});
  }

  // CustomScrollView事件控制器controller
  final ScrollController _controller = ScrollController();

  // GlobalKey 是一个方法可以创建一个key绑定到Widget部件上 可以操作Widget部件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  // 下拉刷新padding
  double _paddingTop = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      // 下拉刷新
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller, // 控制器 可以用于监听滚动事件
          slivers: _getScrollChildren(),
        ),
      ),
    ); // 内容必须是sliver家族
  }
}
