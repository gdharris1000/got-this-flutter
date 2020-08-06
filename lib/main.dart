import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/register.dart';
import 'screens/welcome.dart';
import 'screens/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Got This',
        theme: ThemeData(
            primaryColor: Color.fromRGBO(61, 27, 115, 1.0),
            accentColor: Color.fromRGBO(65, 117, 187, 1.0),
            buttonTheme: ButtonThemeData(
                buttonColor: Color.fromRGBO(65, 117, 187, 1.0),
                textTheme: ButtonTextTheme.primary)),
        initialRoute: WelcomeScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
        });
  }
}
