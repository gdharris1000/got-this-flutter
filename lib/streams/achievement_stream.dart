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
                return Text(achievement.achievement);
              },
              itemCount: achievementList.length);
        }
      },
    );
  }
}
