import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User {
  String? username;

  Map<String, dynamic> joJson() => {
        'username': username,
      };

  User.fromSnapshot(snapshot) : username = snapshot.data()['username'];
}

class Users with ChangeNotifier {
  String? _username;
  String? get username => _username;

  Future<void> getUsername() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser!.uid} - uid')
        .collection('details')
        .get();
    List<User> detailList = List.from(
      data.docs.map(
        (doc) => User.fromSnapshot(doc),
      ),
    );
    _username = detailList[0].username;
    notifyListeners();
  }
}
