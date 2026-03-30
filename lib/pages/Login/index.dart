import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/LoadingDialog.dart';
import 'package:hm_shop/utils/Toastutils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController =
      TextEditingController(); // 账号控制器
  final TextEditingController _passwordController =
      TextEditingController(); // 密码控制器

  final UserController _userController = Get.find(); // 获取用户控制器实例

  // 构建头部
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            '账号密码登录',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // 账号输入框
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        // 校验是否为空
        if (value == null || value.isEmpty) {
          return '手机号不能为空';
        }
        // 校验手机号格式 第一位1 第二位是3-9的数字 后面接9位数字 \d 表示数字
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return '手机号格式不正确';
        }
        return null;
      },
      controller: _phoneController, // 绑定控制器
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 左侧内边距
        hintText: '请输入手机号', // 提示文本
        fillColor: Color.fromRGBO(243, 243, 243, 1), // 背景色
        filled: true, // 填充背景色
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25), // 设置圆角
          borderSide: BorderSide.none, // 去掉边框
        ),
      ),
    );
  }

  // 密码输入框
  Widget _buildPasswordTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '密码不能为空';
        }
        // 密码校验 数字/大小字母/下划线 6-16位
        if (!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)) {
          return '请输入6-16位的字母数字或者下划线';
        }
        return null;
      },
      controller: _passwordController, // 绑定控制器
      obscureText: true, // 隐藏输入内容
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 左侧内边距
        hintText: '请输入密码', // 提示文本
        fillColor: Color.fromRGBO(243, 243, 243, 1), // 背景色
        filled: true, // 填充背景色
        border: OutlineInputBorder(
          borderSide: BorderSide.none, // 去掉边框
          borderRadius: BorderRadius.circular(25), // 设置圆角
        ),
      ),
    );
  }

  // 隐私条款
  bool _isChecked = false; // 复选框状态
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 单选框
        Checkbox(
          value: _isChecked, // 绑定状态
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          }, // 点击事件
          activeColor: Colors.black, // 选中时的颜色
          checkColor: Colors.white, // 勾选符号的颜色
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.grey, width: 2), // 设置边框
        ),
        Text.rich(
          // 富文本
          TextSpan(
            children: [
              TextSpan(text: '查看并同意'),
              TextSpan(
                text: '《隐私政策》',
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: '和'),
              TextSpan(
                text: '《用户协议》',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 登录方法
  _login() async {
    Loadingdialog.show(context, message: '努力登录中...'); // 显示加载框
    try {
      // 调用登录接口
      final res = await loginAPI({
        'account': _phoneController.text,
        'password': _passwordController.text,
      });
      // 只要代码过了await这一步，就说明他已经登陆成功了,没成功会到trycatch这一步
      _userController.updateUserInfo(res); // 更新用户信息到全局状态，不能持久，刷新就没
      tokenManage.setToken(res.token); // 持久化token
      Loadingdialog.hide(context); // 隐藏加载框
      ToastUtils.showToast(context, '登陆成功');
      Navigator.pop(context); // 登录成功后返回上一页
    } catch (e) {
      Loadingdialog.hide(context); // 隐藏加载框
      ToastUtils.showToast(context, (e as DioException).message);
    }
  }

  // 登录按钮
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // 登录按钮
        onPressed: () {
          // 登录逻辑
          // 验证表单
          if (_key.currentState!.validate()) {
            // 验证成功
            // 进行勾选框的判断
            if (_isChecked) {
              // 校验通过
              _login();
            } else {
              // 提示用户勾选用户协议
              ToastUtils.showToast(context, '请同意隐私政策和用户协议');
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // 背景色
          shape: RoundedRectangleBorder(
            // 设置圆角
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text('登录', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>(); // 表单key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('慧多美登录', style: TextStyle(color: Colors.black)),
        ),
      ),
      body: Form(
        key: _key, // 绑定表单key
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 20),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildPasswordTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
