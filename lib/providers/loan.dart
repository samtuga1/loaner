import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Loan {
  String? loanType;
  double? maxAmount;
  double? rate;
  int? time;
  String? id;
  String? status;
  String? createdAt;

  // Returns my data in a map form
  Map<String, dynamic> joJson() => {
        'maxAmount': maxAmount,
        'rate': rate,
        'time': time,
        'loanType': loanType,
        'id': id,
        'createdAt': createdAt
      };

  Loan.fromSnapshot(snapshot)
      : maxAmount = snapshot.data()['maxAmount'].toDouble(),
        loanType = snapshot.data()['loanType'],
        rate = snapshot.data()['rate'].toDouble(),
        time = snapshot.data()['time'],
        id = snapshot.data()['id'],
        createdAt = snapshot.data()['createdAt'];
}

class Loans with ChangeNotifier {
  // Store the loans according to thei respective names
  List<Loan> _recommendedLoans = [];
  List<Loan> _myLoans = [];
  List<Loan> _homeLoans = [];
  List<Loan> _personalLoans = [];
  Loan? _singleLoan;
  Loan? get singleLoanFecthed {
    return _singleLoan;
  }

  List<Loan> get myLoans {
    return _myLoans;
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
            .orderBy('rate', descending: false)
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

  Future<Loan> fetchSingleLoan(String loanId) async {
    final loan = await FirebaseFirestore.instance
        .collection('loans')
        .where('id', isEqualTo: loanId)
        .get();
    final singleLoan =
        List.from(loan.docs.map((doc) => Loan.fromSnapshot(doc)));
    _singleLoan = singleLoan[0];
    notifyListeners();
    return _singleLoan!;
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

  Future<void> fetchMyLoans() async {
    final loan = await FirebaseFirestore.instance
        .collection('loans')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final List<Loan> myLoans =
        List.from(loan.docs.map((doc) => Loan.fromSnapshot(doc)));
    _myLoans = myLoans;
    notifyListeners();
  }

  void deleteLoan(double? maxAmount, String? type, String? createdAt) {
    var loan = FirebaseFirestore.instance
        .collection('loans')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('createdAt', isEqualTo: createdAt)
        .where('loanType', isEqualTo: type)
        .where('maxAmount', isEqualTo: maxAmount);
    var batch = FirebaseFirestore.instance.batch();
    loan.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      return batch.commit();
    });
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
