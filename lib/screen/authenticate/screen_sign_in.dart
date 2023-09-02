import 'package:firebase_demo/services/auth.dart';
import 'package:firebase_demo/shared/constants.dart';
import 'package:firebase_demo/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: const Text('Sign in to Brew'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person, color: Colors.white),
                    label: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                            suffixIcon: Icon(
                              Icons.email,
                            ),
                            hintText: 'E-mail id:'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a valid e-mail id';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                            hintText: 'Password',
                            suffixIcon: Icon(Icons.remove_red_eye)),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter a 6+ password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                error =
                                    'Couldnt sign in with those credentials';
                                loading = false;
                              });
                            } else {
                              ScaffoldMessenger(
                                child: SnackBar(
                                    content: Text(
                                  'You are registered successfully',
                                  style: TextStyle(color: Colors.green),
                                )),
                              );
                            }
                          }
                        },
                        child: Text('Sign in'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 12))
                    ],
                  ),
                )),
          );
  }
}
