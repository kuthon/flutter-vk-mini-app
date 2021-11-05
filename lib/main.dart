import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reaction_test/pages/navigation_page.dart';
import 'package:reaction_test/repository/game_repository.dart';
import 'package:reaction_test/repository/top_repository.dart';
import 'package:reaction_test/repository/vk_user_repository.dart';
import 'package:reaction_test/services/vk_api_service.dart';
import 'package:reaction_test/services/vk_bridge_logger.dart';
import 'package:vk_bridge/vk_bridge.dart';

Future<void> main() async {
  VKBridge.instance.setLogger(SimpleLogger());
  await Firebase.initializeApp();
  await VkApi.init();
  try {
    await VKBridge.instance.init();
    await GameRepository.init();
    await VkUserRepository.init();
    await TopRepository.init();
  } catch (e) {
    debugPrint(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}
