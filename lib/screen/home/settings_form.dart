import 'package:firebase_demo/services/database.dart';
import 'package:firebase_demo/shared/constants.dart';
import 'package:firebase_demo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        try {
          if (snapshot.hasData) {
            UserDataModel userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration:
                        inputDecoration.copyWith(hintText: 'Enter the name:'),
                    validator: ((value) =>
                        value!.isEmpty ? 'Please enter a value' : null),
                    onChanged: ((value) =>
                        setState(() => _currentName = value)),
                  ),
                  SizedBox(height: 20),

                  //dropdown
                  DropdownButtonFormField(
                    decoration: inputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text('$sugar sugar'),
                        value: sugar,
                      );
                    }).toList(),
                    onChanged: ((value) =>
                        setState(() => _currentSugars = value)),
                  ),
                  SizedBox(height: 20),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    divisions: 8,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: ((value) => setState(() {
                          _currentStrength = value.round();
                        })),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        } catch (e) {
          throw (e);
        }
      },
    );
  }
}
