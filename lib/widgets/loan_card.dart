import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
      child: Card(
        elevation: 1,
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
                        child: Image.asset('assets/images/house.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Home loan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Lowest interest as low 0.8%',
                        style: TextStyle(color: Colors.grey),
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
                  const LoanDetailColumn(
                    amount: 12000.00,
                    title: 'Max Amount',
                  ),
                  const LoanDetailColumn(
                    amount: 0.2,
                    title: 'Interest',
                  ),
                  RaisedButton(
                    elevation: 3,
                    color: const Color(0xFF7C71F4),
                    onPressed: () {},
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
      return '$amount%';
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
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
