import 'package:cloud_firestore/cloud_firestore.dart';

class Achievement {
  final String achievement;
  final List<dynamic> categories;
  final List<dynamic> tags;
  final Timestamp created;

  Achievement({this.achievement, this.categories, this.tags, this.created});
}
