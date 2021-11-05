import 'package:flutter/foundation.dart';
import 'package:vk_bridge/vk_bridge.dart';

class SimpleLogger implements Logger {
  @override
  void d(Object message) {
    debugPrint('vk_bridge.d: $message');
  }

  @override
  void e(Object message) {
    debugPrint('vk_bridge.e: $message');
  }
}
