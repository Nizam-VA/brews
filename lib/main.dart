import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/models/user.dart';
import 'package:firebase_demo/screen/wraper.dart';
import 'package:firebase_demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: Wrapper(),
      ),
    );
  }
}
