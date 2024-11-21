import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedprefexam/view/login_screen/login_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('isLogged');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        },
        child: Center(child: Text("Home"),)),
    );
  }
}