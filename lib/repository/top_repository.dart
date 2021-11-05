import 'dart:async';
import 'dart:convert';

import 'package:reaction_test/models/firebase_user_model.dart';
import 'package:reaction_test/models/user_model.dart';
import 'package:reaction_test/repository/vk_user_repository.dart';
import 'package:reaction_test/services/firebase_service.dart';
import 'package:reaction_test/services/vk_api_service.dart';

abstract class TopRepository {
  static late List<FirebaseUserModel> firebaseUsers;
  static List<UserModel> users = [];
  static final FirebaseService _firebaseService = FirebaseService();

  static Future<void> init() async {
    await _firebaseService.signInAnonymously();
    VkApi.usersGetStream.stream.listen((response) {
      if (response == null) return;
      var resJson = jsonDecode(response);
      var vkUsers = resJson['response'];
      List<UserModel> temp = [];
      for (int i = 0; i < vkUsers.length; i++) {
        var fUser = _findFirebaseUser(vkUsers[i]['id']);
        if (fUser != null) {
          temp.add(UserModel(
              gameScoreModel: fUser.gameScoreModel,
              id: vkUsers[i]['id'],
              firstName: vkUsers[i]['first_name'],
              lastName: vkUsers[i]['last_name'],
              profilePicture: vkUsers[i]['photo_50']));
        }
      }
      users = temp;
      usersStream.add(users);
    });
    await updateChart(0, 20);
  }

  static Future<void> updateChart(int offset, int count) async {
    firebaseUsers = await _firebaseService.getChart(offset, count) ?? [];

    List<int> ids = [];
    for (var user in firebaseUsers) {
      ids.add(user.id);
    }

    VkApi.usersGetUpdate(userIds: ids, token: VkUserRepository.token);
  }

  static final StreamController<List<UserModel>?> usersStream = StreamController<List<UserModel>?>();

  static FirebaseUserModel? _findFirebaseUser(int id) {
    for (var user in firebaseUsers) {
      if (user.id == id) {
        return user;
      }
    }
  }
}
