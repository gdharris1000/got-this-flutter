import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:got_this_flutter/streams/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:got_this_flutter/controllers/user_data.dart';

final _firestore = Firestore.instance;

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final UserData getUserInfo = UserData();
  String currentUser = "";
  String docId = "";

  void getUserDocId() async {
    final userData = await _firestore
        .collection('users')
        .where('uid', isEqualTo: currentUser)
        .getDocuments();
    setState(() {
      docId = userData.documents[0].documentID;
      print('docid: $docId');
    });
  }

  void getCurrentUser() {
    getUserInfo.getCurrentUser().then((FirebaseUser result) {
      setState(() {
        currentUser = result.uid;
        getUserDocId();
      });
    });
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('stats'),
            Expanded(child: AchievementDataStream(docId)),
          ],
        ),
      ),
    );
  }
}
