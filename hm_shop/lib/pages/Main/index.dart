import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行渲染4个导航
  // 一般应用程序的导航是固定的 final 定义为常量(不可更改) List列表 Map键值对 String字符串 (列表包裹着键值对对象，里面的类型是String:String)
  final List<Map<String, String>> _tabList = [
    {
      'icon' :'lib/assets/index.png',
      'active_icon': 'lib/assets/index-select.png',
      'text': '首页'
    },
    {
      'icon' :'lib/assets/list.png',
      'active_icon': 'lib/assets/list-select.png',
      'text': '分类'
    },
    {
      'icon' :'lib/assets/shop.png',
      'active_icon': 'lib/assets/shop-select.png',
      'text': '购物车'
    },
    {
      'icon' :'lib/assets/user.png',
      'active_icon': 'lib/assets/user-select.png',
      'text': '我的'
    },
  ];

  // 激活的索引
  int _currentIndex = 0;

  // 返回底部渲染的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]['icon']!, width: 30, height: 30),
        activeIcon: Image.asset(_tabList[index]['active_icon']!, width: 30, height: 30),
        label: _tabList[index]['text'],
        );
    });
  }

  List<Widget> _getChildren () {
    return [
      HomeView(), // 底部导航栏对应的页面
      CategoryView(), // 底部导航栏对应的页面
      CartView(), // 底部导航栏对应的页面
      MineView() // 底部导航栏对应的页面
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //safearea 是安全区，可以避开适配时的刘海屏
        child: SafeArea(
          child: IndexedStack(
            index: _currentIndex, // 索引，点击下面的导航，就会切换到对应的组件
            children: _getChildren(), // 放置几个组件
          )
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true, // 显示未选中的文字
        selectedItemColor: Colors.black, // 选中的颜色
        unselectedItemColor: Colors.black, // 未选中的颜色
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget()
      ),
    );
  }
}