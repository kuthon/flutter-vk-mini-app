import 'package:reaction_test/pages/scores_page/scores_contract.dart';
import 'package:reaction_test/pages/scores_page/scores_model.dart';
import 'package:reaction_test/repository/game_repository.dart';

class ScoresPresenter {
  ScoresContract? _view;
  ScoresModel? _model;

  ScoresPresenter() {
    _model = ScoresModel(bestScore: GameRepository.bestGame, scores: GameRepository.scores);
  }

  set scoresView(ScoresContract view) {
    _view = view;
    _view!.model = _model!;
  }

  void onUpdate() {
    _model = ScoresModel(bestScore: GameRepository.bestGame, scores: GameRepository.scores);
    _view!.model = _model!;
  }
}
