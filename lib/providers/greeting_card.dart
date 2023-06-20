import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePicture with ChangeNotifier {
  String? _profileImage;
  String? get profilePicture => _profileImage;

  Future<String> getProfilePicture() async {
    final ref = FirebaseStorage.instance
        .ref('user_images')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
    String? image = await ref.getDownloadURL();
    return image;
    // _profileImage = image;
    // notifyListeners();
  }
}
