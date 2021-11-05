import 'package:flutter/material.dart';
import 'package:reaction_test/pages/top_page/top_contract.dart';
import 'package:reaction_test/pages/top_page/top_model.dart';
import 'package:reaction_test/pages/top_page/top_presenter.dart';
import 'package:url_launcher/url_launcher.dart';

class TopPage extends StatefulWidget {
  final TopPresenter _presenter = TopPresenter();

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> implements TopContract {
  TopModel? _model;

  @override
  set model(TopModel model) {
    _model = model;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    widget._presenter.topView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_model!.users == []) return const Text('Ожидайте...');

    return SizedBox.expand(
        child: Column(children: [
      const SizedBox(
        height: 15,
      ),
      Text(
        'Топ игроков',
        style: Theme.of(context).textTheme.headline6,
      ),
      const SizedBox(
        height: 30,
      ),
      ListView.builder(
          shrinkWrap: true,
          itemCount: _model!.users.length,
          itemBuilder: (context, index) {
            return ListTile(
              mouseCursor: MaterialStateMouseCursor.clickable,
              onTap: () {
                launch('https://vk.com/${_model!.users[index].id}');
              },
              trailing: Text(_model!.users[index].gameScoreModel.score.toString()),
              title: Text('${_model!.users[index].firstName} ${_model!.users[index].lastName}'),
              leading: SizedBox(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_model!.offset + index + 1}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        _model!.users[index].profilePicture,
                        errorBuilder: (context, _, __) {
                          return Container(
                            width: 50,
                            height: 50,
                            color: Colors.tealAccent,
                            child: const Center(
                              child: Text(
                                'Произошла ошибка при загрузке фотографии',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 8),
                                softWrap: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
    ]));
  }
}
