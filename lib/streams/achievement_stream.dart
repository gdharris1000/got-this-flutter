import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/achievement.dart';
import 'package:got_this_flutter/controllers/user_data.dart';

final _firestore = Firestore.instance;

class AchievementStream extends StatefulWidget {
  final String docId;
  AchievementStream(this.docId);

  @override
  _AchievementStreamState createState() => _AchievementStreamState();
}

class _AchievementStreamState extends State<AchievementStream> {
  final UserData userData = UserData();

  @override
  void initState() {
    // TODO: implement initState
    print("stream docid: ${widget.docId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .document(widget.docId)
          .collection('achievements')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print("no achievement stream data");
          return Center(child: Text('Loading'));
        } else {
          List<Achievement> achievementList = [];
          final achievements = snapshot.data.documents.reversed;

          for (var achievementData in achievements) {
            achievementList.add(Achievement(
                achievement: achievementData.data['achievement'],
                categories: achievementData.data['categories'],
                tags: achievementData.data['tags'],
                created: achievementData.data['created']));
          }

          return ListView.builder(
              itemBuilder: (context, index) {
                final achievement = achievementList[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text("Achievement: ${achievement.achievement}"),
                      Text("Categories: ${achievement.categories.toString()}"),
                      Text("Tags: ${achievement.tags.toString()}"),
                      Text(
                          "Created on: ${achievement.created.toDate().toString()}"),
                    ],
                  ),
                );
              },
              itemCount: achievementList.length);
        }
      },
    );
  }
}
