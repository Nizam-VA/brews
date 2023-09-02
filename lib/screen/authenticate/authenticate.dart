import 'package:firebase_demo/screen/authenticate/register.dart';
import 'package:firebase_demo/screen/authenticate/screen_sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: SignIn(
          toggleView: toggleView,
        ),
      );
    } else {
      return Container(
        child: Register(
          toggleView: toggleView,
        ),
      );
    }
  }
}
