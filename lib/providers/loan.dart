import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Loan {
  String? loanType;
  double? maxAmount;
  double? rate;
  int? time;
  String? id;

  Loan({
    required this.loanType,
    required this.maxAmount,
  });

  // Returns my data in a map form
  Map<String, dynamic> joJson() => {
        'maxAmount': maxAmount,
        'rate': rate,
        'time': time,
        'loanType': loanType,
        'id': id
      };

  Loan.fromSnapshot(snapshot)
      : maxAmount = snapshot.data()['maxAmount'].toDouble(),
        loanType = snapshot.data()['loanType'],
        rate = snapshot.data()['rate'].toDouble(),
        time = snapshot.data()['time'],
        id = snapshot.data()['id'];
}

class Loans with ChangeNotifier {
  // Store the loans according to thei respective names
  List<Loan> _recommendedLoans = [];
  List<Loan> _homeLoans = [];
  List<Loan> _personalLoans = [];
  Loan? _singleLoan;
  Loan? get singleLoanFecthed {
    return _singleLoan;
  }

  List<Loan> get recommendedLoans {
    return [..._recommendedLoans];
  }

  List<Loan> get homeLoans {
    return [..._homeLoans];
  }

  List<Loan> get personalLoans {
    return [..._personalLoans];
  }

//Method for fetching loans
//Takes two arguments for filtering
  Future<void> fetchLoans({String? loanType, String? loanType2}) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('loans')
          .where('loanType', isEqualTo: loanType)
          .get(); //Gets the loans data

      //Iterates over the data that is being fetched
      List<Loan> loanList = List.from(
        data.docs.map(
          (doc) => Loan.fromSnapshot(doc),
        ),
      );
      if (loanType == 'personal') {
        _personalLoans = loanList; //Returens personal loans
      }
      if (loanType == 'home') {
        _homeLoans = loanList; //Returens home loans
      }

      // This logic fetches recommended loans(all loans with interest in ascending form)
      if (loanType2 == 'recommended') {
        var data = await FirebaseFirestore.instance
            .collection('loans')
            .orderBy('interest', descending: false)
            .get();
        List<Loan> loanList = List.from(
          data.docs.map(
            (doc) => Loan.fromSnapshot(doc),
          ),
        );
        _recommendedLoans = loanList;
      }
      notifyListeners(); // Notifify all listeners
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchSingleLoan(String loanId) async {
    final loan = await FirebaseFirestore.instance
        .collection('loans')
        .where('id', isEqualTo: loanId)
        .get();
    final singleLoan =
        List.from(loan.docs.map((doc) => Loan.fromSnapshot(doc)));
    _singleLoan = singleLoan[0];
    notifyListeners();
  }

  Future<void> fetchRecommendedLoans() async {
    await fetchLoans(loanType2: 'recommended', loanType: 'home');
  }

  Future<void> fetchPersonalLoans() async {
    await fetchLoans(loanType: 'personal');
  }

  Future<void> fetchHomeLoans() async {
    await fetchLoans(loanType: 'home');
  }

  double? calculateInterest({double? totalToBePaid, double? maxAmount}) {
    final interest = totalToBePaid! - maxAmount!.toDouble();
    return double.parse(interest.toStringAsFixed(2));
  }

  double? calculateEMI({double? maxAmount, double? rate, int? time}) {
    final rateToBeUsed =
        (rate! / 100) / 12; // Converts rate to be used in monthly installments

    final numerator =
        maxAmount! * rateToBeUsed * pow((1 + rateToBeUsed), (time! * 12));

    final denomenator = pow((1 + rateToBeUsed), (time * 12)) - 1;

    final emi = numerator / denomenator; // returns the final emi to be used
    return double.parse(emi.toStringAsFixed(2));
  }

  double? totalToRepay({double? emi, time}) {
    final total = emi! * (time * 12);
    return double.parse(total.toStringAsFixed(2));
  }
}
