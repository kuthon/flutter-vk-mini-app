import 'package:reaction_test/models/game_score_model.dart';
import 'package:reaction_test/repository/vk_user_repository.dart';
import 'package:reaction_test/services/firebase_service.dart';
import 'package:reaction_test/services/vk_storage.dart';
import 'package:reaction_test/utils/compare_natural.dart';

abstract class GameRepository {
  static int count = 0;
  static late GameScoreModel bestGame;
  static List<GameScoreModel> scores = [];

  static final VKStorage _storage = VKStorage();
  static final FirebaseService _firebaseService = FirebaseService();

  static Future<void> init() async {
    await Future.wait([_updateCount(), _updateBestGame()]);
    await _updateScores();
  }

  static Future<void> _updateBestGame() async {
    var resBestScore = await _storage.get(['best_score']);
    bestGame = GameScoreModel.fromJSON(resBestScore?.first?.value);
  }

  static Future<void> _updateCount() async {
    var resCount = await _storage.get(['count']);
    count = int.tryParse(resCount?.first?.value) ?? 0;
  }

  static Future<void> _updateScores() async {
    List<String> keys = [];
    for (int i = 0; i < count; i++) {
      keys.add('game$i');
    }
    var resPairs = (await _storage.get(keys)).toList();
    resPairs.sort((a, b) => compareNatural(a.key, b.key));

    for (var pair in resPairs) {
      scores.add(GameScoreModel.fromJSON(pair.value));
    }
  }

  static Future<void> saveGameScore(GameScoreModel data) async {
    if (data.score > bestGame.score) {
      _storage.set('best_score', data.toJSON());
      _firebaseService.saveBestResult(VkUserRepository.user.id.toString(), data);
      bestGame = data;
    }
    _storage.set('game$count', data.toJSON());
    _storage.set('count', '${count + 1}');
    count += 1;
    scores.add(data);
  }
}
