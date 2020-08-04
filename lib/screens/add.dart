import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/category.dart';
import 'package:got_this_flutter/classes/tag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:got_this_flutter/controllers/user_data.dart';

final _firestore = Firestore.instance;

class AddScreen extends StatefulWidget {
  static const String id = 'add';

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final UserData userData = UserData();
  String userId = "";
  String docId = "";
  List<Category> categories = [
    Category(label: 'Work', status: false),
    Category(label: 'Self', status: false),
    Category(label: 'Play', status: false),
    Category(label: 'Living', status: false)
  ];

  List<Tag> tags = [
    Tag(label: 'Health, Wellbeing, Fitness', status: false),
    Tag(label: 'Creating', status: false),
    Tag(label: 'New Developments', status: false),
    Tag(label: 'Giving', status: false),
    Tag(label: 'Receiving', status: false),
    Tag(label: 'Other', status: false)
  ];

  String achievementText = "";

//  List<Achievement> achievements = [];

  void addAchievement() async {
    List<String> _categories = [];
    List<String> _tags = [];

    categories.forEach((e) {
      if (e.status) {
        _categories.add(e.label);
      }
    });

    tags.forEach((e) {
      if (e.status) {
        _tags.add(e.label);
      }
    });

    _firestore
        .collection('users')
        .document(docId)
        .collection('achievements')
        .document()
        .setData({
      'achievement': achievementText,
      'categories': _categories,
      'tags': _tags,
      'created': Timestamp.now()
    });

//    achievements.add(Achievement(
//        achievement: achievementText, categories: _categories, tags: _tags));
  }

  void getUserDocId() async {
    final userData = await _firestore
        .collection('users')
        .where('uid', isEqualTo: userId)
        .getDocuments();
    docId = userData.documents[0].documentID;
    print('docid: $docId');
  }

  void getCurrentUser() {
    userData.getCurrentUser().then((FirebaseUser result) {
      setState(() {
        userId = result.uid;
        getUserDocId();
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
      appBar: AppBar(
        title: Text('Add Achievement'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(hintText: 'Enter your achievement'),
            onChanged: (value) {
              setState(() {
                achievementText = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CheckboxListTile(
                    title: Text(category.label),
                    value: category.status,
                    onChanged: (bool value) {
                      setState(() {
                        category.status = value;
                      });
                    },
                  );
                },
                itemCount: categories.length),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return CheckboxListTile(
                    title: Text(tag.label),
                    value: tag.status,
                    onChanged: (bool value) {
                      setState(() {
                        tag.status = value;
                      });
                    },
                  );
                },
                itemCount: tags.length),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              addAchievement();
            },
          )
        ],
      )),
    );
  }
}
