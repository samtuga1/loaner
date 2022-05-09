import 'package:flutter/material.dart';
import 'package:loaner/providers/loan.dart';
import 'package:loaner/widgets/app_drawer.dart';
import 'package:loaner/widgets/greetings_banner.dart';
import 'package:loaner/widgets/my_loan_card.dart';
import 'package:provider/provider.dart';

class MyLoansScreen extends StatelessWidget {
  static const routeName = '/my_loans';
  const MyLoansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(children: [
          const GreetingBarner(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: FutureBuilder(
                future:
                    Provider.of<Loans>(context, listen: false).fetchMyLoans(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('error');
                  } else {
                    return Consumer<Loans>(
                      builder: (context, loans, child) => ListView.builder(
                        itemCount: loans.myLoans.length,
                        itemBuilder: (BuildContext context, int index) {
                          final myLoan = loans.myLoans[index];
                          return Column(
                            children: [
                              Dismissible(
                                background: Container(
                                  color: Colors.redAccent,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin:
                                          const EdgeInsets.only(right: 14.0),
                                      child: const Icon(
                                        Icons.delete,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                key: ValueKey(loans.myLoans[index].id),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  loans.deleteLoan(
                                    myLoan.maxAmount,
                                    myLoan.loanType,
                                    myLoan.createdAt,
                                  );
                                },
                                child: MyLoanCard(
                                  maxAmount: myLoan.maxAmount,
                                  createdAt: myLoan.createdAt,
                                  type: myLoan.loanType,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
