import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reaction_test/models/firebase_user_model.dart';
import 'package:reaction_test/models/game_score_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<UserCredential?> signInAnonymously() async {
    try {
      UserCredential user = await _auth.signInAnonymously();
      return user;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveBestResult(String vkId, GameScoreModel score) async {
    try {
      await _usersCollection.doc(vkId).set(score.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<FirebaseUserModel>?> getChart(int offset, int count) async {
    try {
      var res =
          await _usersCollection.orderBy('score', descending: true).limit(offset + count).limitToLast(count).get();
      return res.docs
          .map((score) => FirebaseUserModel(int.parse(score.id), GameScoreModel.fromJSON(score.data())))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
