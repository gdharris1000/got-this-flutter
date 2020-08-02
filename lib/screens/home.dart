import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/category.dart';
import 'package:got_this_flutter/classes/tag.dart';
import 'package:got_this_flutter/classes/achievement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [
    Category(label: 'Work', status: false),
    Category(label: 'Self', status: true),
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

  List<Achievement> achievements = [];

  void addAchievement() {
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

    achievements.add(Achievement(
        achievement: achievementText, categories: _categories, tags: _tags));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              print(achievements);
            },
          )
        ],
      )),
    );
  }
}
