import 'package:flutter/material.dart';

class CompletedScreen extends StatelessWidget {
  static const routeName = '/completed';
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color(0xFF7E73F5)),
      ),
    );
  }
}
