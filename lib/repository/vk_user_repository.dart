import 'package:vk_bridge/vk_bridge.dart';

abstract class VkUserRepository {
  static var user;
  static late String token;

  static Future<void> init() async {
    await Future.wait([updateUserInfo(), updateToken()]);
  }

  static Future<void> updateUserInfo() async {
    user = await VKBridge.instance.getUserInfo();
  }

  static Future<void> updateToken() async {
    token = (await VKBridge.instance.getAuthToken(appId: 7990090, scope: '')).accessToken;
  }
}
