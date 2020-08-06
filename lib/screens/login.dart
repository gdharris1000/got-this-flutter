import 'package:flutter/material.dart';
import 'package:got_this_flutter/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:got_this_flutter/mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: formKey,
                child: Flexible(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(hintText: 'E-mail address'),
                        onChanged: (value) => email = value,
                        validator: emailValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Password'),
                        obscureText: true,
                        onChanged: (value) => password = value,
                        validator: passwordValidator,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text('Log in'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
