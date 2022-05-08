import 'package:flutter/material.dart';

class MyLoanCard extends StatelessWidget {
  const MyLoanCard(
      {Key? key, this.maxAmount, this.status, this.type, this.createdAt})
      : super(key: key);
  final double? maxAmount;
  final String? status;
  final String? type;
  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: status == null
          ? () {
              print('my loans');
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.2, color: Colors.grey),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$maxAmount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1D22),
                  ),
                ),
                Text(
                  status == null ? 'Interest' : status!,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7e73f5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type == 'personal' ? 'Personal Loan' : 'Home Loan',
                  style: const TextStyle(
                    fontSize: 15.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  createdAt!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
