import 'package:flutter/material.dart';

Step verificationScreen(int _currentStep) {
  return Step(
    isActive: _currentStep >= 2,
    title: const Text('Get Loan'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Verify your details to get',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          leading: Icon(
            Icons.check,
            color: Colors.green,
          ),
          title: Text('Up to 5% lower interest'),
        ),
        ListTile(
          leading: Icon(
            Icons.check,
            color: Colors.green,
          ),
          title: Text('Up to 20% higher loan amount'),
        ),
        ListTile(
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
