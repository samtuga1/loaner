import 'package:flutter/material.dart';
import 'package:loaner/providers/user_loan.dart';
import 'package:loaner/widgets/app_drawer.dart';
import 'package:loaner/widgets/greetings_banner.dart';
import 'package:provider/provider.dart';

import '../widgets/my_loan_card.dart';

class MyLoansScreen extends StatelessWidget {
  static const routeName = '/my_loans';
  MyLoansScreen({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFF7F5FF),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreetingBarner(drawerKey: _scaffoldKey),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: const Text(
              'My Loans',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1D22),
                fontSize: 18.4,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                  future: Provider.of<UserLoans>(context, listen: false)
                      .fetchUserLoans(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Consumer<UserLoans>(
                        builder: (context, loans, _) => ListView.builder(
                          itemCount: loans.userLoans.length,
                          itemBuilder: (ctx, i) => MyLoanCard(
                            createdAt: loans.userLoans[i].createdAt,
                            maxAmount: loans.userLoans[i].maxAmount,
                            type: loans.userLoans[i].type,
                            status: loans.userLoans[i].status,
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ),
        ],
      )),
    );
  }
}
