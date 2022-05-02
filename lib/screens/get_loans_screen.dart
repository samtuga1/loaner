import 'package:flutter/material.dart';
import 'package:loaner/providers/loan.dart';
import 'package:loaner/screens/completed_screen.dart';
import 'package:provider/provider.dart';
import '../screens/verification_screen.dart';
import '../screens/bank_detail.dart';
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
    final loanId = ModalRoute.of(context)!.settings.arguments as String;
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
                child: FutureBuilder(
                  future: Provider.of<Loans>(context, listen: false)
                      .fetchSingleLoan(loanId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.data);
                      print(snapshot.error);
                      return const Text('Error');
                    } else {
                      return Consumer<Loans>(builder: (context, loans, _) {
                        final emi = loans.calculateEMI(
                          maxAmount: loans.singleLoanFecthed!.maxAmount,
                          rate: loans.singleLoanFecthed!.rate,
                          time: loans.singleLoanFecthed!.time,
                        );
                        return Stack(
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
                                loanDetailScreen(
                                  loanAmount:
                                      loans.singleLoanFecthed!.maxAmount,
                                  rate: loans.singleLoanFecthed!.rate,
                                  time: loans.singleLoanFecthed!.time,
                                  emi: loans.calculateEMI(
                                    maxAmount:
                                        loans.singleLoanFecthed!.maxAmount,
                                    rate: loans.singleLoanFecthed!.rate,
                                    time: loans.singleLoanFecthed!.time,
                                  ),
                                ),
                                personalCredentialsScreen(_currentStep),
                                verificationScreen(
                                  currentStep: _currentStep,
                                  emi: emi,
                                  totalToBePayed: loans.totalToRepay(
                                    emi: emi,
                                    time: loans.singleLoanFecthed!.time,
                                  ),
                                  rate: loans.singleLoanFecthed!.rate,
                                ),
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
                                  Navigator.of(context).pushReplacementNamed(
                                      CompletedScreen.routeName);
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
                        );
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
