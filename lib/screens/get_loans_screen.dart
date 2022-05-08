import 'package:flutter/material.dart';
import 'package:loaner/providers/loan.dart';
import 'package:loaner/screens/completed_screen.dart';
import 'package:provider/provider.dart';
import '../screens/verification_screen.dart';
import '../screens/bank_detail.dart';
import '../widgets/stepper_buttons.dart';
import '../screens/loan_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loaner/providers/loan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  bool isLoading = false;

  Future<void> sendRequest(String loanId, Loan requestedLoan) async {
    String loanStatus = 'Awaiting';
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${FirebaseAuth.instance.currentUser!.uid} - uid')
          .collection('requested_loans')
          .doc(requestedLoan.id)
          .set({
        'maxAmount': requestedLoan.maxAmount,
        'type': requestedLoan.loanType,
        'status': loanStatus,
        'createdAt': currentDate,
      }).then((_) {
        Navigator.of(context).pushReplacementNamed(
          CompletedScreen.routeName,
        );
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          content: Text('Please try again later'),
          title: Text(' An error occured!'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

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
                      return const Center(
                        child: Text(
                          'Error fetching data, kindly try again later',
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      );
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
                                  sendRequest(loanId, loans.singleLoanFecthed!);
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
                                isLoading: isLoading,
                                loanId: loanId,
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
