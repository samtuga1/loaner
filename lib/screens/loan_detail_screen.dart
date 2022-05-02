import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:dotted_line/dotted_line.dart';

Step loanDetailScreen(
    {final double? loanAmount,
    final double? emi,
    final int? time,
    final double? rate}) {
  int _currentStep = 0;

  return Step(
    isActive: _currentStep >= 0,
    title: const Text('Loan Details'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getSingleLoanDetail(loanAmount, 'Loan Amount'),
        const SizedBox(
          height: 40,
        ),
        getSingleLoanDetail(emi, 'EMI Amount'),
        const SizedBox(
          height: 40,
        ),
        Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'EMI Tenure',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          '${time! * 12} months',
                          style: const TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Annual interest',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          '$rate%',
                          style: const TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 1.2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'EMI Calender',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      'Amount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const DottedLine(
          dashLength: 2.5,
          dashColor: Colors.grey,
        ),
      ],
    ),
  );
}

Column getSingleLoanDetail(double? _value, String? title) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.5),
            ),
            child: Text(
              '\$$_value',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF229855),
              ),
            ),
          )
        ],
      ),
      // SfSliderTheme(
      //   data: SfSliderThemeData(
      //     activeTrackColor: const Color(0xFF7367F1),
      //     thumbColor: const Color(0xFF7367F1),
      //     activeTrackHeight: 3.95,
      //     inactiveTrackHeight: 5.0,
      //   ),
      //   child: SfSlider(
      //     inactiveColor: Colors.grey,
      //     min: 0,
      //     max: _value! + 100.0,
      //     value: _value,
      //     interval: (_value.round() / 4).round().toDouble(),
      //     showTicks: true,
      //     showLabels: true,
      //     enableTooltip: true,
      //     minorTicksPerInterval: 1,
      //     onChanged: (dynamic value) {
      //       _value = value;
      //     },
      //   ),
      // ),
    ],
  );
}
