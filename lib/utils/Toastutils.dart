import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context, String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 圆角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        width: 120,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5), // 显示时长
        content: Text(msg ?? '加载成功！', textAlign: TextAlign.center),
      ),
    );
  }
}
