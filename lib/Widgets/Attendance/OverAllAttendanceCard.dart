import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';

class OverallAttendanceCard extends StatefulWidget {
  @override
  _OverallAttendanceCardState createState() => _OverallAttendanceCardState();
}

class _OverallAttendanceCardState extends State<OverallAttendanceCard>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.6, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth_services auth_services = Auth_services();

    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: Auth_services().getAttendanceSheet(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map(
                            (e) => userdata['Class'] == e['Class']
                                ? Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Title: ' + e['Title'],
                                            style: TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Subject: ' + e['SubAttendance'],
                                            style: TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Posted by: ' + e['postedBy'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  ' At ' +
                                                      e['date']
                                                          .toString()
                                                          .split(' ')
                                                          .first,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'File: ' + e['docName'],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Download'),
                                                        Icon(Icons
                                                            .download_outlined),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  print(e['AttendancesDocs']);
                                                  print(e['docName']);
                                                  File file = await auth_services
                                                      .downloadFile(
                                                          e['AttendanceDocs'],
                                                          e['docName']);
                                                  print(
                                                      "Stored PDF: ${file.path}");
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          )
                          .toList(),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
