import 'package:dashboard/pages/landing.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'New England v Tennessee Titans',
      //theme: ThemeData(primarySwatch: Colors.blue),
      theme: ThemeData(fontFamily: 'Monsterrat-Regular'),
      home: LandingPage(),
    );
  }
}