import 'dart:convert';

class GameScoreModel {
  late final int averageResult;
  late final List<int> results;
  late final int score;

  GameScoreModel(this.results) {
    averageResult = results.reduce((a, b) => a + b) ~/ results.length;
    int temp = 0;
    for (var value in results) {
      temp += 100000 ~/ value;
    }
    score = temp;
  }

  GameScoreModel.fromJSON(dynamic data) {
    var json;
    if (data is String) {
      try {
        json = jsonDecode(data);
      } catch (e) {
        json = {};
      }
    } else {
      json = data;
    }
    averageResult = json['average_result'] ?? 0;
    results = (json['results'] == '' || json['results'] == null) ? [] : json['results'].cast<int>();
    score = json['score'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {"results": results, "average_result": averageResult, "score": score};
  }

  String toJSON() {
    return jsonEncode({"results": results, "average_result": averageResult, "score": score});
  }

  @override
  String toString() {
    return 'GameScore(results: $results,average_result: $averageResult,score: $score)';
  }
}
