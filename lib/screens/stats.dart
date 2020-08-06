import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/tag.dart';
import 'package:got_this_flutter/classes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final _firestore = Firestore.instance;

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

  List categoryLabels() {
    List catLabels = [];
    for (var i in categories) {
      catLabels.add(i.label);
    }
    return catLabels;
  }

  void getData() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('stats'),
          ],
        ),
      ),
    );
  }
}
