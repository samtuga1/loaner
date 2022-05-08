import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RequestedLoan {
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

  RequestedLoan.fromSnapshot(snapshot)
      : maxAmount = snapshot.data()['maxAmount'].toDouble(),
        type = snapshot.data()['type'],
        createdAt = snapshot.data()['createdAt'],
        status = snapshot.data()['status'],
        id = snapshot.data()['id'];
}

class RequestedLoans with ChangeNotifier {
  List<RequestedLoan> _requestedLoans = [];
  List<RequestedLoan> get requestedLoans {
    return [..._requestedLoans];
  }

  Future<void> fetchUserLoans() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser!.uid} - uid')
        .collection('requested_loans')
        .get();
    List<RequestedLoan> loanList = List.from(
      data.docs.map(
        (doc) => RequestedLoan.fromSnapshot(doc),
      ),
    );
    _requestedLoans = loanList;
  }
}
