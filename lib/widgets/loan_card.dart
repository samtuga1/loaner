import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loaner/screens/get_loans_screen.dart';

class LoanCard extends StatelessWidget {
  const LoanCard(
      {Key? key,
      required this.loanType,
      required this.maxAmount,
      required this.interest,
      required this.rate,
      required this.id})
      : super(key: key);
  final String? loanType;
  final double? maxAmount;
  final double? interest;
  final double? rate;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
      child: Card(
        elevation: 1.5,
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCF1EF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          loanType == 'home'
                              ? 'assets/images/house.png'
                              : 'assets/images/personal-money.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loanType == 'home' ? 'Home loan' : 'Personal Loan',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Rate of loan is $rate%',
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoanDetailColumn(
                    amount: maxAmount!,
                    title: 'Max Amount',
                  ),
                  LoanDetailColumn(
                    amount: interest!,
                    title: 'Interest',
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: const Color(0xFF7C71F4),
                    ),
                    onPressed: () {
                      if (id == FirebaseAuth.instance.currentUser!.uid) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: const Color(0xFF7A6FF2),
                            content: const Text(
                              'Sorry, you cannot apply for your own loan',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            title: const Text(
                              'Alert!',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white60,
                                ),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text(
                                  'Go back',
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        Navigator.of(context)
                            .pushNamed(GetLoansScreen.routeName, arguments: id);
                      }
                    },
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoanDetailColumn extends StatelessWidget {
  final double amount;
  final String title;

  const LoanDetailColumn({
    Key? key,
    required this.amount,
    required this.title,
  }) : super(key: key);

  String getAmount() {
    if (title == 'Max Amount') {
      return '\$$amount';
    } else {
      return '\$$amount';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAmount(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
