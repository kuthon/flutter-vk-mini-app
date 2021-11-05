class GameModel {
  GameModel({required this.state, required this.results, required this.numberOfAttempts});

  final GameState state;
  final List<int?> results;
  final int numberOfAttempts;
}

enum GameState { notActive, inProcess, done }
