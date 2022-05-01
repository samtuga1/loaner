import 'package:flutter/material.dart';
import '../screens/verification_screen.dart';
import '../screens/personal_Credentials_Screen.dart';
import '../widgets/stepper_buttons.dart';
import '../screens/loan_detail_screen.dart';

class GetLoansScreen extends StatefulWidget {
  static const routeName = '/get_loans_screen';
  const GetLoansScreen({Key? key}) : super(key: key);

  @override
  State<GetLoansScreen> createState() => _GetLoansScreenState();
}

class _GetLoansScreenState extends State<GetLoansScreen> {
  double maxAmount = 30;
  int _currentStep = 0;
  var _onStepContinue;
  var _onStepCancel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).scaffoldBackgroundColor,
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.4),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Text(
                      'Get Loan',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Stepper(
                      controlsBuilder: (context, details) {
                        _onStepContinue = details.onStepContinue;
                        _onStepCancel = details.onStepCancel;
                        return const SizedBox.shrink();
                      },
                      elevation: 0,
                      type: StepperType.horizontal,
                      steps: [
                        loanDetailScreen(),
                        personalCredentialsScreen(_currentStep),
                        verificationScreen(_currentStep),
                      ],
                      currentStep: _currentStep,
                      onStepTapped: (int newIndex) {
                        setState(() {
                          _currentStep = newIndex;
                        });
                      },
                      onStepContinue: () {
                        if (_currentStep != 2) {
                          setState(() {
                            _currentStep++;
                          });
                        } else {
                          print('done');
                        }
                      },
                      onStepCancel: () {
                        if (_currentStep != 0) {
                          setState(() {
                            _currentStep--;
                          });
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: StepperButton(
                        currentIndex: _currentStep,
                        nextPressed: () {
                          _onStepContinue();
                        },
                        backPressed: () {
                          _onStepCancel();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
