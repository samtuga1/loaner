import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: const Color(0xff857BEE),
          backgroundColor: const Color(0xFFF7F5FF),
          textTheme: GoogleFonts.latoTextTheme(textTheme)),
      home: const RegistrationScreen(),
    );
  }
}
