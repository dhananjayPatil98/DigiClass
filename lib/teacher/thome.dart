import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/DashboardCards.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import 'package:school_management/Widgets/UserDetailCard.dart';
import 'package:school_management/Widgets/sprofile.dart';
import 'package:school_management/teacher/ZoomMeeting.dart';
import 'package:school_management/teacher/studentReport.dart';
import 'package:school_management/teacher/teacherAttendance.dart';
import 'package:school_management/teacher/teacherquiz.dart';
import 'package:school_management/teacher/tnotes.dart';
import 'package:school_management/teacher/tassignment.dart';
import 'package:school_management/teacher/viewleave.dart';
import 'package:school_management/zoom/join_screen.dart';

class tHome extends StatefulWidget {
  @override
  _tHomeState createState() => _tHomeState();
}

class _tHomeState extends State<tHome> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIOverlays([]);
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            elevation: 0,
            child: MainDrawer(),
          ),
          appBar: CommonAppBar(
            menuenabled: true,
            notificationenabled: true,
            ontap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            title: "Dashboard",
          ),
          body: ListView(
            children: [
              UserDetailCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TeacherAttendance(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Attendance",
                              imgpath: "attendance.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => sprofile(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Profile",
                              imgpath: "profile.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        QuizTeacher(),
                                  ));
                            },
                            child: DashboardCard(
                              name: "Exam",
                              imgpath: "exam.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ZoomMeetingTeacher(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Live Lecutres",
                              imgpath: "classroom.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Teacherassignment(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Assignments",
                              imgpath: "library.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              print("Hello Notes");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TeacherNotes(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Notes",
                              imgpath: "books.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      StudentReport(),
                                ),
                              );
                            },
                            child: DashboardCard(
                              name: "Report",
                              imgpath: "report-card.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        viewstudentleave(),
                                  ));
                            },
                            child: DashboardCard(
                              name: "Apply Leave",
                              imgpath: "leave_apply.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
