import 'package:flutter/material.dart';
import 'package:got_this_flutter/streams/achievement_stream.dart';
import 'package:got_this_flutter/controllers/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ListScreen extends StatefulWidget {
  static const String id = 'list';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
      child: Column(
        children: <Widget>[
          Expanded(
            child: AchievementStream(docId),
          )
        ],
      ),
    );
  }
}
