import 'package:reaction_test/models/game_score_model.dart';

class UserModel {
  final int id;
  final String profilePicture;
  final String firstName;
  final String lastName;
  final GameScoreModel gameScoreModel;

  UserModel(
      {required this.gameScoreModel,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.profilePicture});
}
