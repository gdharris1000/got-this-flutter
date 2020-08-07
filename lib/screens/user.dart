import 'package:flutter/material.dart';
import 'package:got_this_flutter/controllers/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:got_this_flutter/widgets/alert.dart';

class UserScreen extends StatefulWidget {
  static const String id = 'user';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final UserData userData = UserData();
  String userEmail = "";
  void getCurrentUser() {
    userData.getCurrentUser().then((FirebaseUser result) {
      setState(() {
        userEmail = result.email;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (AppBar(
          title: Text('User Information'),
        )),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Reset Password for $userEmail'),
                  onPressed: () {
                    setState(() async {
                      try {
                        _auth.sendPasswordResetEmail(email: userEmail);
                        AlertMessage alertMessage = AlertMessage(
                            messageContent:
                                'A link to reset your password has been sent to your email address ($userEmail)',
                            messageTitle: 'Password Reset',
                            buildContext: context);
                        alertMessage.displayMessage();
                      } catch (e) {
                        AlertMessage alertMessage = AlertMessage(
                            messageContent:
                                'There was an error in sending the password reset email. Please try again later.',
                            messageTitle: 'Password Reset',
                            buildContext: context);
                        alertMessage.displayMessage();
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
