import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:school_management/Screens/choosee.dart';

class intro_page extends StatelessWidget {
  final pages = [
    PageViewModel(
      pageColor: const Color.fromRGBO(
          0, 157, 204, 1), // To Define page background color
      bubble: Icon(Icons.check_circle), // to define page indicator at bottom
      body: Text(
        'Check School posts to stay updated with school news.Take quizzes, test at home all through your phone',
      ), // compulsory to define body and it will be shown at bottom
      title: Text(
        'Student',
        style: TextStyle(fontSize: 32.0),
      ), // it will be shown at page header
      textStyle: TextStyle(
        color: Colors.black,
      ), // generic text style define for whole page
      mainImage: Image.asset(
        'assets/student.png',
        width: 250.0,
        alignment: Alignment.center,
      ), // to define image for the introduction
    ),
    PageViewModel(
      pageColor: const Color.fromRGBO(193, 88, 206, 1),
      bubble: Icon(Icons.check_circle),
      body: Text(
        'Create posts, and notify your students to keep them updated',
      ),
      title: Text(
        'Teacher',
        style: TextStyle(fontSize: 32.0),
      ),
      mainImage: Image.asset(
        'assets/teacher.png',
        width: 300.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Intro View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          skipText: Text(
            'SKIP',
            style: TextStyle(color: Colors.black),
          ), // Customize skip button
          doneText: Text(
            'GO TO APP',
            style: TextStyle(color: Colors.white),
          ), // Customize done button
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => choosee(),
              ),
            ); // after introduction where to navigate
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
