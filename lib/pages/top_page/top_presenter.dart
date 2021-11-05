import 'package:reaction_test/pages/top_page/top_contract.dart';
import 'package:reaction_test/pages/top_page/top_model.dart';
import 'package:reaction_test/repository/top_repository.dart';

class TopPresenter {
  TopContract? _view;
  TopModel? _model;

  int _offset = 0;

  TopPresenter() {
    _model = TopModel(offset: _offset, users: []);

    TopRepository.usersStream.stream.listen((event) {
      _model = TopModel(offset: _offset, users: event ?? []);
      _view?.model = _model!;
    });
  }

  set topView(TopContract view) {
    _view = view;
    _view!.model = _model!;
  }
}
