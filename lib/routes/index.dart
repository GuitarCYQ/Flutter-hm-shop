import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

Widget getRootWidget () {
    return MaterialApp(
      // 命名路由
      initialRoute: '/', //默认首页路径
      routes: getRootRoutes(),
    );
}

// 返回该App的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => MainPage(),
    '/login': (context) => LoginPage(),
  };
}