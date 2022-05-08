import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:loaner/screens/dashboard.dart';
import 'package:loaner/widgets/app_drawer.dart';

class AddLoanScreen extends StatefulWidget {
  static const routname = '/add_loan';
  AddLoanScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddLoanScreen> createState() => _AddLoanScreenState();
}

class _AddLoanScreenState extends State<AddLoanScreen> {
  late String id;
  //Stores the id of the loan
  late double maxAmount;
  //Stores maxAmount/principal of the loan
  late double rate;
  //Stores rate of the loan
  late String loanType;
  // Stores loan type of the loan
  late int time;
  // Stores the time/period for loan to be payed back
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  bool isPersonalSelected = false;
  bool isHomeSelected = false;

  //Method to submit form
  Future<void> submitForm() async {
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());
    bool formState = _formKey.currentState!.validate();
    if (formState == true) {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance.collection('loans').doc().set({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'maxAmount': maxAmount,
        'loanType': loanType,
        'rate': rate,
        'time': time,
        'createdAt': currentDate,
      });
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Loan Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 27,
                        width: 2,
                      ),
                      Row(
                        children: [
                          ChoiceChip(
                            selectedColor: isPersonalSelected
                                ? const Color(0xFF7B70F3)
                                : null,
                            onSelected: (value) {
                              setState(() {
                                isPersonalSelected = !isPersonalSelected;
                                isHomeSelected = false;
                                if (isPersonalSelected) {
                                  loanType = 'personal';
                                } else {
                                  loanType = '';
                                }
                              });
                            },
                            label: const Text('Personal Loan'),
                            selected: isPersonalSelected,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ChoiceChip(
                            selectedColor:
                                isHomeSelected ? const Color(0xFF7B70F3) : null,
                            onSelected: (value) {
                              setState(() {
                                isHomeSelected = !isHomeSelected;
                                isPersonalSelected = false;
                                if (isHomeSelected) {
                                  loanType = 'home';
                                } else {
                                  loanType = '';
                                }
                              });
                            },
                            label: const Text('Home Loan'),
                            selected: isHomeSelected,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.payment),
                      const SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              maxAmount = double.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the principal of the loan';
                            }
                            if (value.startsWith('0')) {
                              return 'Please enter a valid value';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text('Principal'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.percent_sharp),
                      const SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              rate = double.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter rate of the loan';
                            }
                            if (value.startsWith('0')) {
                              return 'Please enter a valid value';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text('Rate'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.timelapse_rounded),
                      const SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              time = int.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the time/period of the loan';
                            }
                            if (value.startsWith('0')) {
                              return 'Please enter a valid value';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text('Time/Period'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isLoading == true
                      ? Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : InkWell(
                          radius: 40,
                          onTap: submitForm,
                          child: Container(
                            margin: const EdgeInsets.only(top: 25),
                            height: 60,
                            child: const Center(
                              child: Text(
                                'Add Loan',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color(0xFF7B70F3),
                                  const Color(0xFF7B70F3),
                                  const Color(0xFF7B70F3).withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
