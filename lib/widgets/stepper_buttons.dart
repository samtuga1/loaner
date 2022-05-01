import 'package:flutter/material.dart';

class StepperButton extends StatelessWidget {
  const StepperButton(
      {Key? key,
      required this.nextPressed,
      required this.backPressed,
      required this.currentIndex})
      : super(key: key);
  final Function() nextPressed;
  final Function() backPressed;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: currentIndex != 0 ? backPressed : null,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              onTap: nextPressed,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xFF7367F1),
                    Color(0xFF7B70F3),
                  ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    currentIndex == 2 ? 'CONFIRM' : 'NEXT',
                    style: const TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
