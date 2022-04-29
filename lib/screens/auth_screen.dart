import 'package:flutter/material.dart';
import 'package:loaner/widgets/profile_form.dart';
import 'package:loaner/widgets/registration_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loginMode = true;
  void switchSignType() {
    setState(() {
      _loginMode = !_loginMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_loginMode)
                const Align(
                  alignment: Alignment.center,
                  child: ProfileForm(),
                ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  'Welcome 👋',
                  style: textTheme.headline4!.copyWith(color: Colors.black87),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 8, bottom: 10),
                child: Text(
                  _loginMode == true ? 'Login now' : 'Signup to get started',
                  style: textTheme.headline6!
                      .copyWith(color: Colors.black54, fontSize: 20),
                ),
              ),
              RegistrationForm(loginMode: _loginMode),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: switchSignType,
                  child: Text(
                    _loginMode == true
                        ? 'Create account instead'
                        : 'Already have an account?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
