import 'package:vk_bridge/vk_bridge.dart';

class VKStorage {
  Future set(String key, String value) async {
    var res = await VKBridge.instance.storageSet(key: key, value: value);
    return res.result;
  }

  Future get(List<String> keys) async {
    var res = await VKBridge.instance.storageGet(keys);
    return res.keys;
  }

  Future getKeys() async {
    var res = await VKBridge.instance.storageGetKeys();
    return res.keys;
  }

  Future delete(String key) async {
    var res = await VKBridge.instance.storageSet(key: key, value: null);
    return res.result;
  }
}
