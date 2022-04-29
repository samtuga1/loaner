import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/greetings_banner.dart';
import '../widgets/loan_card.dart';
import '../widgets/loan_type.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  Dashboard({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          GreetingBarner(dashboardKey: _scaffoldKey),
          const BalanceCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              LoanType(
                title: 'Personal',
                imgUrl: 'assets/images/personal-money.png',
              ),
              LoanType(
                title: 'Home',
                imgUrl: 'assets/images/house.png',
              ),
              LoanType(
                title: 'EMI',
                imgUrl: 'assets/images/calculator.png',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended Loans',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FlatButton(
                  onPressed: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (ctx, i) => const LoanCard(),
            ),
          )
        ],
      ),
    );
  }
}
