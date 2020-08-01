import 'package:flutter/material.dart';
import 'package:got_this_flutter/classes/category.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Category> categories = [
    Category(label: 'Work', status: false),
    Category(label: 'Self', status: true),
    Category(label: 'Play', status: false),
    Category(label: 'Living', status: false)
  ];
  final List<String> tags = [
    'Health, Wellbeing, Fitness',
    'Creating',
    'New Developments',
    'Giving',
    'Receiving',
    'Other'
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
        ],
      )),
    );
  }
}
