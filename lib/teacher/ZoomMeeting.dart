import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/teacher/viewStudAttend.dart';
import 'package:school_management/zoom/createmeeting.dart';

class ZoomMeetingTeacher extends StatefulWidget {
  @override
  _ZoomMeetingTeacherState createState() => _ZoomMeetingTeacherState();
}

class _ZoomMeetingTeacherState extends State<ZoomMeetingTeacher> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Meetings'),
        titleSpacing: 2,
        centerTitle: true,
        backgroundColor: getcolor(),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: Auth_services().getMeetingData(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs
                      .map(
                        (e) => userdata['uid'] == e['UserId']
                            ? Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.zero,
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        e['Title'],
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Posted by: ' + e['PostedBy'],
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ' At ' +
                                                  e['PostedDate']
                                                      .toString()
                                                      .split(' ')
                                                      .first,
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Subject: ' + e['Subject'],
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Meet ID: ' + e['MeetID'],
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Meet Password: ' + e['Pass'],
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
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
                                                    Text('Delete'),
                                                    Icon(Icons.close_rounded),
                                                  ],
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Do you want to delete this file"),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          Auth_services()
                                                              .deleteMeetingData(
                                                            e['DocId'],
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                          _scaffoldKey
                                                              .currentState
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  'File deleted'),
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      400],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          OutlinedButton(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        'Student Attended Meet'),
                                                    Icon(Icons.navigate_next),
                                                  ],
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ViewStudAttend(
                                                    docId: e['DocId'],
                                                  ),
                                                ),
                                              );
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
              return Container();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: getcolor(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateMeeting(),
            ),
          );
        },
        label: Text(
          'CREATE MEETING',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
