import 'package:flutter/material.dart';
import 'package:loaner/providers/loan.dart' as loans_provider;
import '../screens/recommended_loans_screen.dart';
import '../widgets/balance_card.dart';
import '../widgets/greetings_banner.dart';
import '../widgets/loan_card.dart';
import '../widgets/loan_type.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  Dashboard({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isInit = true;

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
            padding: const EdgeInsets.only(left: 18.0, right: 16, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended Loans',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RecommendedLoansScreen.routeName);
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: (() =>
                  Provider.of<loans_provider.Loans>(context, listen: false)
                      .fetchRecommendedLoans()),
              child: FutureBuilder(
                future:
                    Provider.of<loans_provider.Loans>(context, listen: false)
                        .fetchRecommendedLoans(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Consumer<loans_provider.Loans>(
                      builder: (context, loanData, _) => ListView.builder(
                        itemBuilder: (ctx, i) {
                          return LoanCard(
                            loanType: loanData.recommendedLoans[i].loanType,
                            maxAmount: loanData.recommendedLoans[i].maxAmount!
                                .toDouble(),
                            interest: loanData.recommendedLoans[i].interest!
                                .toDouble(),
                          );
                        },
                        itemCount: loanData.recommendedLoans.length,
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
