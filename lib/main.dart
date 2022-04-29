import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loaner/screens/dashboard.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Removes the debug banner
      title: 'Loan Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F5FF),
        backgroundColor: const Color(0xFFFFFFFF),
        textTheme: GoogleFonts.ptSansTextTheme(textTheme),
      ),
      home: Dashboard(),
    );
  }
}
