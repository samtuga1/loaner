import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './providers/greeting_card.dart';
import './providers/loan.dart';
import './providers/user.dart';
import './screens/add_loan_screen.dart';
import './screens/completed_screen.dart';
import './screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/get_loans_screen.dart';
import './screens/home_loans_screen.dart';
import './screens/my_loans_screen.dart';
import './screens/recommended_loans_screen.dart';
import 'package:provider/provider.dart';
import 'providers/requested_loan.dart';
import './screens/auth_screen.dart';
import './screens/personal_loans_screen.dart';
import './screens/requested_loans_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Loans()),
          ChangeNotifierProvider(create: (context) => RequestedLoans()),
          ChangeNotifierProvider(create: (context) => ProfilePicture()),
          ChangeNotifierProvider(create: (context) => Users()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //Removes the debug banner
          title: 'Loan Manager',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF7F5FF),
            backgroundColor: const Color(0xFFFFFFFF),
            textTheme: GoogleFonts.ptSansTextTheme(textTheme),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Dashboard();
              } else {
                return const AuthScreen();
              }
            },
          ),
          routes: {
            RecommendedLoansScreen.routeName: (context) =>
                const RecommendedLoansScreen(),
            BankDetailsScreen.routeName: (context) => const BankDetailsScreen(),
            HomeLoansScreen.routeName: (context) => const HomeLoansScreen(),
            GetLoansScreen.routeName: (context) => const GetLoansScreen(),
            CompletedScreen.routeName: (context) => const CompletedScreen(),
            Dashboard.routeName: (context) => Dashboard(),
            RequestedLoansScreen.routeName: (context) => RequestedLoansScreen(),
            AddLoanScreen.routname: (context) => AddLoanScreen(),
            MyLoansScreen.routeName: (context) => const MyLoansScreen(),
          },
        ));
  }
}
