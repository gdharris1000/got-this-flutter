import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/achievement.dart';
import 'package:got_this_flutter/controllers/user_data.dart';
import 'package:got_this_flutter/classes/category_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

final _firestore = Firestore.instance;

class AchievementDataStream extends StatefulWidget {
  final String docId;
  AchievementDataStream(this.docId);

  @override
  _AchievementDataStreamState createState() => _AchievementDataStreamState();
}

class _AchievementDataStreamState extends State<AchievementDataStream> {
  final UserData userData = UserData();

  @override
  void initState() {
    // TODO: implement initState
    print("stream docid: ${widget.docId}");
    super.initState();
  }

  List<CategoryData> dataCount(List<Achievement> data) {
    int work = 0;
    int self = 0;
    int play = 0;
    int living = 0;

    data.forEach((element) {
      element.categories.forEach((element) {
        if (element == 'Work') {
          work++;
        } else if (element == 'Self') {
          self++;
        } else if (element == 'Play') {
          play++;
        } else if (element == 'Living') {
          living++;
        }
      });
    });

    List<CategoryData> dataList = [
      CategoryData('Work', work),
      CategoryData('Self', self),
      CategoryData('Play', play),
      CategoryData('Living', living)
    ];
    print(dataList);
    return dataList;
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

          List<charts.Series<CategoryData, String>> series = [
            charts.Series(
                id: 'Categories',
                data: dataCount(achievementList),
                domainFn: (CategoryData series, _) => series.category,
                measureFn: (CategoryData series, _) => series.count,
                colorFn: (CategoryData series, _) =>
                    charts.ColorUtil.fromDartColor(
                        Color.fromRGBO(18, 69, 89, 1.0)))
          ];
          return charts.BarChart(
            series,
            animate: true,
          );
        }
      },
    );
  }
}
