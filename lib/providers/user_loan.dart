import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserLoan {
  String? id;
  String? status;
  double? maxAmount;
  String? createdAt;
  String? type;

  Map<String, dynamic> joJson() => {
        'maxAmount': maxAmount,
        'type': type,
        'id': id,
        'status': status,
        'createdAt': createdAt,
      };

  UserLoan.fromSnapshot(snapshot)
      : maxAmount = snapshot.data()['maxAmount'].toDouble(),
        type = snapshot.data()['type'],
        createdAt = snapshot.data()['createdAt'],
        status = snapshot.data()['status'],
        id = snapshot.data()['id'];
}

class UserLoans with ChangeNotifier {
  List<UserLoan> _userLoans = [];
  List<UserLoan> get userLoans {
    return [..._userLoans];
  }

  Future<void> fetchUserLoans() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc('949rFdUbldcoC3i6PomP')
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('my_loans')
        .get();
    List<UserLoan> loanList = List.from(
      data.docs.map(
        (doc) => UserLoan.fromSnapshot(doc),
      ),
    );
    _userLoans = loanList;
  }
}
