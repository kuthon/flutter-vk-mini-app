import 'package:flutter/material.dart';
import 'package:reaction_test/pages/game_page/game_contract.dart';
import 'package:reaction_test/pages/game_page/game_model.dart';
import 'package:reaction_test/pages/game_page/game_presenter.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  final GamePresenter _presenter = GamePresenter();

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> implements GameContract {
  GameModel? _model;

  @override
  set model(GameModel model) {
    _model = model;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    widget._presenter.gameView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Удерживайте палец до появления красного цвета',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: FittedBox(
                  child: Listener(
                    onPointerDown: (_) {
                      widget._presenter.onTap();
                    },
                    onPointerUp: (_) {
                      widget._presenter.onTap();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: _getColorByGameState(_model!.state), borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < _model!.numberOfAttempts; i++)
                    Icon(
                      _model!.results.length > i ? Icons.check_circle : Icons.check_circle_outline,
                      color: _model!.results.length > i ? Colors.green : Colors.grey,
                      size: 30,
                    ),
                ],
              )
            ],
          ),
        ),
        if (_model!.results.length == _model!.numberOfAttempts)
          Container(
            width: double.infinity,
            color: Theme.of(context).shadowColor.withOpacity(0.9),
            child: Center(
                child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Игра окончена!',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Ваши результаты:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ..._model!.results
                        .map((e) => Text(
                              '\n - $e мс',
                              style: Theme.of(context).textTheme.bodyText1,
                            ))
                        .toList(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      child: Text(
                        'Играть снова',
                        style: TextStyle(fontSize: Theme.of(context).textTheme.headline6!.fontSize),
                      ),
                      onPressed: () {
                        widget._presenter.onPlayAgain();
                      },
                    ),
                  ],
                ),
              ),
            )),
          )
      ],
    );
  }
}

_getColorByGameState(GameState state) {
  switch (state) {
    case GameState.notActive:
      return Colors.grey;
    case GameState.inProcess:
      return Colors.yellow;
    case GameState.done:
      return Colors.red;
  }
}
