import 'package:reaction_test/models/game_score_model.dart';

class ScoresModel {
  ScoresModel({required this.scores, required this.bestScore});

  final List<GameScoreModel> scores;
  final GameScoreModel bestScore;
}
