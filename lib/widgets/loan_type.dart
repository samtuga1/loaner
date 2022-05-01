import 'package:flutter/material.dart';
import 'package:loaner/screens/home_loans_screen.dart';
import 'package:loaner/screens/personal_loans_screen.dart';

class LoanType extends StatelessWidget {
  const LoanType({
    Key? key,
    required this.title,
    required this.imgUrl,
  }) : super(key: key);
  final String title;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (title == 'Personal') {
              Navigator.of(context).pushNamed(PersonalLoansScreen.routeName);
            }
            if (title == 'Home') {
              Navigator.of(context).pushNamed(HomeLoansScreen.routeName);
            }
          },
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 2,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0.3),
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  elevation: 0,
                  child: Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(imgUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
