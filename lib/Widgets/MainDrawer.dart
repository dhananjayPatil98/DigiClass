import 'package:flutter/material.dart';
import 'package:school_management/Screens/Attendance/Attendance.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Widgets/DrawerListTile.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/teacher/tlogin.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final Auth_services _auth = Auth_services();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerListTile(
            imgpath: "home.png",
            name: "Home",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
            }),
        DrawerListTile(
          imgpath: "settings.png",
          name: "Settings",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Attendance(),
              ),
            );
          },
        ),
        DrawerListTile(
            imgpath: "signout.png",
            name: "Sign out",
            ontap: () async {
              await _auth.signoutuser();
              if (userdata["isTeacher"] == 'false')
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage(),
                  ),
                );
              else if (userdata["isTeacher"] == 'true')
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => tlogin(),
                  ),
                );
              else
                return null;
            }),
      ],
    );
  }
}
