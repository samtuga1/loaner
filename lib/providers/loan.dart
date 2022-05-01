import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  String? loanType;
  double? maxAmount;
  double? interest;

  Loan({
    required this.loanType,
    required this.interest,
    required this.maxAmount,
  });

  Map<String, dynamic> joJson() =>
      {'maxAmount': maxAmount, 'interest': interest, 'loanType': loanType};

  Loan.fromSnapshot(snapshot)
      : maxAmount = snapshot.data()['maxAmount'],
        interest = snapshot.data()['interest'],
        loanType = snapshot.data()['loanType'];
}

class Loans with ChangeNotifier {
  // Store the loans
  List<Loan> _recommendedLoans = [];
  List<Loan> _homeLoans = [];
  List<Loan> _personalLoans = [];
  List<Loan> get recommendedLoans {
    return [..._recommendedLoans];
  }

  List<Loan> get homeLoans {
    return [..._homeLoans];
  }

  List<Loan> get personalLoans {
    return [..._personalLoans];
  }

  Future<void> fetchLoans({String? loanType, String? loanType2}) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('loans')
          .where('loanType', isEqualTo: loanType)
          .get();
      List<Loan> loanList = List.from(
        data.docs.map(
          (doc) => Loan.fromSnapshot(doc),
        ),
      );
      if (loanType == 'personal') {
        _personalLoans = loanList;
      }
      if (loanType == 'home') {
        _homeLoans = loanList;
      }
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
      notifyListeners();
    } catch (error) {
      print(error);
      return;
    }
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
}
