import 'package:flutter/material.dart';

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
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
            border: Border.all(width: 2, color: Colors.white),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0.3),
              child: Card(
                color: Colors.white,
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
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
