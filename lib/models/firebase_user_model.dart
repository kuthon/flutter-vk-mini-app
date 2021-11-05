import 'package:reaction_test/models/game_score_model.dart';

class FirebaseUserModel {
  final int id;
  final GameScoreModel gameScoreModel;

  FirebaseUserModel(this.id, this.gameScoreModel);
}
