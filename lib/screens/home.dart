import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/category.dart';
import 'package:got_this_flutter/classes/tag.dart';

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

  final List<Tag> tags = [
    Tag(label: 'Health, Wellbeing, Fitness', status: false),
    Tag(label: 'Creating', status: false),
    Tag(label: 'New Developments', status: false),
    Tag(label: 'Giving', status: false),
    Tag(label: 'Receiving', status: false),
    Tag(label: 'Other', status: false)
  ];

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
        ],
      )),
    );
  }
}
