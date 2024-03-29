import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/add_loan_screen.dart';
import '../screens/dashboard.dart';
import '../screens/my_loans_screen.dart';
import '../screens/requested_loans_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF877DF8),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Dashboard.routeName);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.home_filled,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white70,
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(MyLoansScreen.routeName);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),
                      title: Text(
                        'My Loans',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white70,
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AddLoanScreen.routname);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.playlist_add,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Add Loan',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white70,
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RequestedLoansScreen.routeName);
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Requested Loans',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white70,
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () async {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signOut();
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white70,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
