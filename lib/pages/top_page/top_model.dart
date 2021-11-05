import 'package:reaction_test/models/user_model.dart';

class TopModel {
  TopModel({required this.offset, required this.users});

  final int offset;

  final List<UserModel> users;
}
