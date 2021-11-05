import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:reaction_test/models/game_score_model.dart';
import 'package:reaction_test/repository/game_repository.dart';

import 'game_contract.dart';
import 'game_model.dart';

class GamePresenter {
  GameContract? _view;
  GameModel? _model;

  final numberOfGames = 3;
  final randomGenerator = Random(DateTime.now().millisecond);

  Timer? _timer;
  DateTime? _expectedTime;
  int _ping = 0;

  GamePresenter() {
    _model = GameModel(state: GameState.notActive, results: [], numberOfAttempts: 3);
  }

  set gameView(GameContract view) {
    _view = view;
    _view!.model = _model!;
  }

  void updateView() {
    _view!.model = _model!;
  }

  void onPlayAgain() {
    GameRepository.saveGameScore(GameScoreModel(_model!.results.cast<int>()));
    _model = GameModel(numberOfAttempts: numberOfGames, results: [], state: GameState.notActive);
    updateView();
  }

  void onTap() {
    if (_model!.state == GameState.notActive) {
      _onTapDown();
    } else if (_model!.state == GameState.inProcess) {
      _onTapUpEarly();
    } else if (_model!.state == GameState.done) {
      _onTapUp();
    }

    updateView();
  }

  void _onTapDown() {
    Duration randomDuration =
        Duration(seconds: randomGenerator.nextInt(5) + 1, milliseconds: randomGenerator.nextInt(999));
    DateTime timeNow = DateTime.now();
    _expectedTime = timeNow.add(randomDuration);
    _model = GameModel(state: GameState.inProcess, results: _model?.results ?? [], numberOfAttempts: 3);

    _timer = Timer(randomDuration, () {
      _model = GameModel(state: GameState.done, results: _model!.results, numberOfAttempts: numberOfGames);
      _view!.model = _model!;
      _ping = DateTime.now().difference(_expectedTime!).inMilliseconds * 2;
      debugPrint('ping: $_ping');
    });
  }

  void _onTapUpEarly() {
    _timer!.cancel();
    _model = GameModel(state: GameState.notActive, results: [], numberOfAttempts: 3);
  }

  void _onTapUp() {
    DateTime timeNow = DateTime.now();
    int dif = timeNow.difference(_expectedTime!).inMilliseconds - _ping;
    _model!.results.add(dif > 0 ? dif : 0);
    _model = GameModel(state: GameState.notActive, results: _model!.results, numberOfAttempts: 3);
  }
}
