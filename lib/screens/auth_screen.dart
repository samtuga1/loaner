import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loaner/widgets/registration_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  bool _loginMode = true;
  void switchSignType() {
    setState(() {
      _loginMode = !_loginMode;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> submitFm(
    String email,
    String username,
    File? image,
    String password,
  ) async {
    setState(() {
      isLoading = true;
    });
    final _auth = FirebaseAuth.instance;
    try {
      if (_loginMode) {
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref('user_images')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(image!);
        //final imageUrl = ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc('${authResult.user!.uid} - uid')
            .collection('details')
            .add({'username': username, 'email': email});
      }
    } on FirebaseAuthException catch (error) {
      String message = 'An error occured, kindly try again later';
      if (error.toString().contains('[firebase_auth/user-not-found]')) {
        message = 'There is no user registered under this email';
      } else if (error.toString().contains('[firebase_auth/wrong-password]')) {
        message = 'Kindly check the password and try again';
      }
      _showSnackBar(message);
    } catch (err) {
      _showSnackBar('An error occured, kindly try again later');
    }
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  'Welcome 👋',
                  style: textTheme.headline4!.copyWith(color: Colors.black87),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 8, bottom: 10),
                child: Text(
                  _loginMode == true ? 'Login now' : 'Signup to get started',
                  style: textTheme.headline6!
                      .copyWith(color: Colors.black54, fontSize: 20),
                ),
              ),
              RegistrationForm(
                loginMode: _loginMode,
                ctx: context,
                submitFm: submitFm,
                isLoading: isLoading,
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: switchSignType,
                  child: Text(
                    _loginMode == true
                        ? 'Create account instead'
                        : 'Already have an account?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
