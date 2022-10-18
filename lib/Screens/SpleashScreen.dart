import 'dart:async';
import 'package:school_management/services/currentuser.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Screens/intro_page.dart';
import 'package:school_management/teacher/thome.dart';

class SpleashScreen extends StatefulWidget {
  @override
  _SpleashScreenState createState() => _SpleashScreenState();
}

class _SpleashScreenState extends State<SpleashScreen> {
  @override
  @override
  void initState() {
    Timer(Duration(seconds: 8), start);
    getMyData();
  }

  getMyData() async {
    await getCurrentData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 0.35,
            child: FlareActor(
              "assets/school spleash.flr",
              animation: "start",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  start() {
    try {
      if (userdata == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => intro_page(),
          ),
        );
      } else {
        if (userdata["isTeacher"] == 'false')
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Home(),
              ),
            );
          });
        else if (userdata["isTeacher"] == 'true')
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => tHome(),
              ),
            );
          });
        else
          print('ERROR !104! contact NASA');
      }
    } catch (e) {
      print(e);
    }
  }
}
