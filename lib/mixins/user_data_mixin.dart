import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class UserDataMixin {
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        return loggedInUser.uid;
      }
    } catch (e) {
      print('user data error: $e');
    }
  }

  getDocID(String uid) async {
    String docId;
    try {
      final currentUser = await _firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .getDocuments();
      docId = currentUser.documents[0].documentID;
      return docId;
    } catch (e) {
      print('doc id error: $e');
    }
  }

//
//
//  Future<String> getUserDocId() async {
//
//    userData.getCurrentUser().then((FirebaseUser result) await {
//       _firestore
//          .collection('users')
//          .where('uid', isEqualTo: result.uid)
//          .getDocuments()
//          .then((result) {
//        return result.documents[0].documentID.toString();
//      });
//    });
//
//    String uid = getCurrentUser();
//    await _firestore
//        .collection('users')
//        .where('uid', isEqualTo: uid)
//        .getDocuments()
//        .then((result) {
//      return result.documents[0].documentID.toString();
//    });
//  }
//
//  String getCurrentUser() {
//    userData.getCurrentUser().then((FirebaseUser result) {
//      return result.uid;
//    });
//  }
}
