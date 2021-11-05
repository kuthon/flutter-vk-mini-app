import 'package:flutter/material.dart';
import 'package:reaction_test/pages/scores_page/scores_contract.dart';
import 'package:reaction_test/pages/scores_page/scores_model.dart';
import 'package:reaction_test/pages/scores_page/scores_presenter.dart';
import 'package:reaction_test/presentation/vk_icons.dart';

class ScoresPage extends StatefulWidget {
  final ScoresPresenter _presenter = ScoresPresenter();

  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> implements ScoresContract {
  ScoresModel? _model;

  @override
  set model(ScoresModel model) {
    _model = model;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    widget._presenter.scoresView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              'Лучший результат: ${_model!.bestScore.score}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Все результаты:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Container(height: 15, color: Theme.of(context).scaffoldBackgroundColor),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Попытки')),
                      DataColumn(label: Text('Среднее значение')),
                      DataColumn(label: Text('Общий счёт')),
                    ],
                    rows: _model!.scores.reversed.map((score) {
                      String str = '';
                      for (int i = 0; i < score.results.length; i++) {
                        str += "${score.results[i]}";
                        if (i != score.results.length - 1) {
                          str += ", ";
                        }
                      }
                      return DataRow(cells: [
                        DataCell(Text(str)),
                        DataCell(Text('${score.averageResult}')),
                        DataCell(Text('${score.score}')),
                      ]);
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._presenter.onUpdate();
        },
        child: const Icon(VKIcons.refresh_outline_28),
      ),
    );
  }
}
