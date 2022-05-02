import 'package:flutter/material.dart';
import 'package:loaner/widgets/loan_card.dart';
import 'package:provider/provider.dart';
import '../providers/loan.dart' as loans_provider;

class BankDetailsScreen extends StatelessWidget {
  static const routeName = '/personal_screen';
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loans = Provider.of<loans_provider.Loans>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  const Text(
                    'Personal Loans',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    Provider.of<loans_provider.Loans>(context, listen: false)
                        .fetchPersonalLoans(),
                child: FutureBuilder(
                  future:
                      Provider.of<loans_provider.Loans>(context, listen: false)
                          .fetchPersonalLoans(),
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
                            final type = loanData.personalLoans[i].loanType;
                            final rate = loanData.personalLoans[i].rate;
                            final maxAmount =
                                loanData.personalLoans[i].maxAmount;
                            final time = loanData.personalLoans[i].time;
                            final emi = loans.calculateEMI(
                                maxAmount: maxAmount, time: time, rate: rate);
                            final totalToBePayed =
                                loans.totalToRepay(emi: emi, time: time);
                            final interest = loans.calculateInterest(
                                maxAmount: maxAmount,
                                totalToBePaid: totalToBePayed);
                            return LoanCard(
                              id: loanId,
                              loanType: type,
                              maxAmount: maxAmount,
                              interest: interest,
                              rate: rate,
                            );
                          },
                          itemCount: loanData.personalLoans.length,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
