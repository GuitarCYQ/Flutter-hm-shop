import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进渲染4个导航
  // 一般应用程序的导航是固定不变的
  final List<Map<String, String>> _tabList = [
    {
      "icon": 'lib/assets/ic_public_home_normal.png',
      "active_icon": 'lib/assets/ic_public_home_active.png',
      'title': '首页',
    },
    {
      "icon": 'lib/assets/ic_public_pro_normal.png',
      "active_icon": 'lib/assets/ic_public_pro_active.png',
      'title': '分类',
    },
    {
      "icon": 'lib/assets/ic_public_cart_normal.png',
      "active_icon": 'lib/assets/ic_public_cart_active.png',
      'title': '购物车',
    },
    {
      "icon": 'lib/assets/ic_public_my_normal.png',
      "active_icon": 'lib/assets/ic_public_my_active.png',
      'title': '我的',
    },
  ];

  // 底部导航选中的索引
  int _currentIndex = 3;

  // 返回底部渲染的4个分类
  List<BottomNavigationBarItem> _getTabBarWIdget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          _tabList[index]['icon']!,
          width: 30,
          height: 30,
        ), // 未选中的图标
        activeIcon: Image.asset(
          _tabList[index]['active_icon']!,
          width: 30,
          height: 30,
        ), // 选中的图标
        label: _tabList[index]['title'], // 底部导航的标题
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea安全区域 IndexedStack 堆叠组件
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex, // 当前堆叠组件的索引
          children: _getChildren(), // 几个导航就放几个内容
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          // index是点击后的索引
          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex, // 当前索引
        items: _getTabBarWIdget(),
        selectedItemColor: Colors.black, // 选中的项的颜色
        showUnselectedLabels: true, // 是否让未选择项active的项显示文字
        unselectedItemColor: Colors.black, // 未选中项的颜色
      ),
    );
  }
}
