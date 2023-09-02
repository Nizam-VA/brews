import 'package:firebase_demo/services/auth.dart';
import 'package:firebase_demo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person, color: Colors.white),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
