import 'package:flutter/material.dart';
import 'package:loaner/widgets/greetings_banner.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  Dashboard({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          GreetingBarner(dashboardKey: _scaffoldKey),
        ],
      ),
    );
  }
}
