import 'package:book_bytes/models/user.dart';
import 'package:book_bytes/screens/loginscreen.dart';
import 'package:book_bytes/screens/registration.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final User user;
  const Settings({super.key, required this.user});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String maintitle = "Settings";

  @override
  void initState() {
    super.initState();
    print("Settings");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) =>  const LoginScreen()));
            }, 
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) =>  const Registration()));
            }, 
            child: const Text("Register"),),
        ]),
      );
      
  }

}