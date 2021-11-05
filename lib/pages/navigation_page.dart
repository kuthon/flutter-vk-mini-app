import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reaction_test/pages/scores_page/scores_view.dart';
import 'package:reaction_test/pages/top_page/top_view.dart';
import 'package:reaction_test/presentation/vk_icons.dart';

import 'game_page/game_view.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final pages = [GamePage(), ScoresPage(), TopPage()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест на реакцию'),
      ),
      body: Stack(
          children: pages
              .asMap()
              .map((index, page) => MapEntry(
                  index,
                  Offstage(
                    child: page,
                    offstage: selectedIndex != index,
                  )))
              .values
              .toList()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (newIndex) => setState(() {
          selectedIndex = newIndex;
        }),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(VKIcons.game_outline_28), activeIcon: Icon(VKIcons.game_28), label: 'Играть'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_score_outlined), activeIcon: Icon(Icons.sports_score), label: 'Результаты'),
          BottomNavigationBarItem(icon: Icon(VKIcons.stars_20), activeIcon: Icon(VKIcons.stars_20), label: 'Рейтинг'),
        ],
      ),
    );
  }
}
