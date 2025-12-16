import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  HmMoreList({Key? key}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    // 必须是Sliver家族的组件
    // builder 按需引入
    return SliverGrid.builder(
      gridDelegate: 
        // 网格是两列
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
      ),
      itemCount: 20, // 显示20个商品格子，每个格子都是一个Container
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text('商品$index', style: TextStyle(color: Colors.white)),
          color: Colors.blue,
          alignment: Alignment.center, // 居中
        );
      },
    );
  }
}