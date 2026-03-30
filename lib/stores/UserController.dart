import 'package:get/state_manager.dart';
import 'package:hm_shop/viewmodels/user.dart';

// 这个就是需要共享的对象 里面有一些共享的属性 属性还需要响应式更新
class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs; // obs表示user对象被监听了
  // 想要去值 就需要 xxx.value 例如：user.value
  // 更新方法
  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
