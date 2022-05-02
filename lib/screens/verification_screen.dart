import 'package:flutter/material.dart';

Step verificationScreen(
    {int? currentStep, double? totalToBePayed, double? emi, double? rate}) {
  return Step(
    isActive: currentStep! >= 2,
    title: const Text('Get Loan'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your details to get',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          leading: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          title: Text('Get loan at a rate of $rate%'),
        ),
        ListTile(
          leading: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          title: Text('You pay a total amount of \$$totalToBePayed'),
        ),
        ListTile(
          leading: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          title: Text('You pay \$$emi equaly monthly installments'),
        ),
        const ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.grey,
          ),
          title: Text(
            'By clicking confirm, you agree to the terms and conditions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}
