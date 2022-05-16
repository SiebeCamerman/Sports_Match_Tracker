import 'package:flutter/material.dart';
import 'package:sports_match_tracker/pages/HomeScreen.dart';
import 'package:sports_match_tracker/pages/LoadingScreen.dart';
import 'package:sports_match_tracker/pages/ActiveMatch.dart';
import 'package:sports_match_tracker/pages/CreateMatch.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    //initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/HomeScreen': (context) => Home(),
      '/CreateMatch': (context) => CreateMatch(),
      '/ActiveMatch': (context) => ActiveScreen(),
    },
  ));
}

