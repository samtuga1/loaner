import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm(
      {Key? key,
      required this.isLoading,
      required this.loginMode,
      required this.ctx,
      required this.submitFm})
      : super(key: key);
  final bool loginMode;
  final dynamic ctx;
  final bool isLoading;
  final Function(
    String email,
    String username,
    String password,
  ) submitFm;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String _email = ''; //Stores email of the user
  String _username = ''; //Stores username of the user
  String _password = ''; //Stores password of the user
  final _formKey = GlobalKey<FormState>();

  //Method to submit form
  Future<void> submitForm() async {
    FocusScope.of(context).unfocus();
    bool formState = _formKey.currentState!.validate();
    if (formState == true) {
      widget.submitFm(_email, _username, _password);
    }
  }

  final passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!widget.loginMode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Icon(Icons.account_circle),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    child: TextFormField(
                      key: const ValueKey('username'),
                      onChanged: (value) {
                        setState(() {
                          _username = value.trim();
                        });
                      },
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'Please enter 4 or more characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Username'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(Icons.key),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: TextFormField(
                    key: const ValueKey('password'),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Please enter 6 or more characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: InkWell(
                    radius: 40,
                    onTap: submitForm,
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 60,
                      child: Center(
                        child: Text(
                          widget.loginMode ? 'Login' : 'Get Started',
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
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
                ),
        ],
      ),
    );
  }
}
