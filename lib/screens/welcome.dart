import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "Please log in or register",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                child: Text('Login'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RegisterScreen.id),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
