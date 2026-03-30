import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tokenmanager {
  // 返回持久化对象的实例对象, 后续直接使用_getInstance()就可以调用方法，不需要SharedPrefencences.getInstance()去获取
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = ''; // 定义一个私有的token属性
  // 初始化,通过异步把token获取到并且赋值给_token
  init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置token
  Future<void> setToken(String val) async {
    // 1.获取持久化实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val); //将token写入到持久化里
    _token = val; // 同步更新_token的值
  }

  // 获取token, 同步方法，因为api请求的时候要使用同步，使用异步会报类型错误
  String getToken() {
    return _token;
  }

  // 删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); // 从持久化里删除token
    _token = ''; // 同步更新_token的值
  }
}

// 创建Tokenmanager的单例实例
final tokenManage = Tokenmanager();
