import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    if (ToastUtils.showLoading) {
      return;
    }
    ToastUtils.showLoading = true;
    // 3秒后关闭阀门 showLoading = false;
    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 圆角
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3), // 显示时长
        content: Text(msg ?? '加载成功！', textAlign: TextAlign.center),
      ),
    );
  }
}
