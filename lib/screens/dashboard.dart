import 'package:flutter/material.dart';
import 'package:loaner/providers/loan.dart' as loans_provider;
import 'package:loaner/widgets/app_drawer.dart';
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

  final bool isInit = true;

  // @override
  // void initState() {
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestPermission();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
  //     print(msg.notification!.body);
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
  //     print(msg.data);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final loans = Provider.of<loans_provider.Loans>(context, listen: false);
    return Scaffold(
      drawer: const AppDrawer(),
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          GreetingBarner(drawerKey: _scaffoldKey),
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
                          final loanId = loanData.recommendedLoans[i].id;
                          final type = loanData.recommendedLoans[i].loanType;
                          final rate = loanData.recommendedLoans[i].rate;
                          final maxAmount =
                              loanData.recommendedLoans[i].maxAmount;
                          final time = loanData.recommendedLoans[i].time;
                          final emi = loans.calculateEMI(
                              maxAmount: maxAmount, time: time, rate: rate);
                          final totalToBePayed =
                              loans.totalToRepay(emi: emi, time: time);
                          final interest = loans.calculateInterest(
                              maxAmount: maxAmount,
                              totalToBePaid: totalToBePayed);
                          return LoanCard(
                            loanType: type,
                            id: loanId,
                            maxAmount: maxAmount!.toDouble(),
                            interest: interest,
                            rate: rate,
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
