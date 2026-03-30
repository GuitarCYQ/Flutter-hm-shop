import 'package:flutter/material.dart';

class Loadingdialog {
  // 显示加载框
  static void show(BuildContext context, {String message = '加载中...'}) {
    showDialog(
      context: context,
      builder: (content) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, //占比空间最小
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(message),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 隐藏加载框
  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
