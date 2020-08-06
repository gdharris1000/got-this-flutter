import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AchievementItem extends StatelessWidget {
  final String achievement;
  final List categories;
  final List tags;

  AchievementItem({this.achievement, this.categories, this.tags});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        title: Text(achievement),
//        leading: Text(categories.toString()),
        subtitle: Text(
            "Categories: ${tags.toString()}\nTags: ${categories.toString()}"),
        leading: FaIcon(
          FontAwesomeIcons.trophy,
          color: Color.fromRGBO(224, 132, 9, 1.0),
        ),
      ),
    );
  }
}
