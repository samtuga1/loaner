import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Image.asset('assets/login.png'),
          )
        ],
      )),
    );
  }
}
