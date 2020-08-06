import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:got_this_flutter/screens/stats.dart';
import 'list.dart';
import 'add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:got_this_flutter/controllers/user_data.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _firestore = Firestore.instance;
  final UserData userData = UserData();
  String userId = "";
  String docId = "";

  static List<Widget> _navOptions = <Widget>[
    AddScreen(),
//    StatsScreen(),
    ListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(61, 27, 115, 1.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidPlusSquare),
              title: Text('New Achievement')),
//          BottomNavigationBarItem(
//              icon: FaIcon(FontAwesomeIcons.solidChartBar),
//              title: Text('Stats')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidListAlt),
              title: Text('List Achievements')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(145, 241, 230, 1.0),
        unselectedItemColor: Color.fromRGBO(65, 117, 187, 1.0),
        onTap: _onItemTapped,
      ),
      body: _navOptions.elementAt(_selectedIndex),
    );
  }
}
