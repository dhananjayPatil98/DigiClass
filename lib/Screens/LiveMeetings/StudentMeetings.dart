import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/zoom/meeting_screen.dart';
import 'package:school_management/management/meeting.dart';
import 'package:intl/intl.dart';

class StudentMeetingJoin extends StatefulWidget {
  @override
  _StudentMeetingJoinState createState() => _StudentMeetingJoinState();
}

class _StudentMeetingJoinState extends State<StudentMeetingJoin> {
  DateTime curdate = DateTime.now();
  String formattedDate;
  MeetingController meetingController = Get.put(MeetingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curdate);
  }

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
                        (e) => userdata['Class'] == e['Class']
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
                                              style: TextStyle(fontSize: 15),
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
                                              style: TextStyle(fontSize: 15),
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
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Join'),
                                                    Icon(Icons
                                                        .navigate_next_outlined),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            onPressed: () async {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder:
                                              //         (BuildContext context) =>
                                              //             JoinWidget(
                                              //       documentId: e['DocId'],
                                              //       subject: e['Subject'],
                                              //       title: e['Title'],
                                              //       postedby: e['PostedBy'],
                                              //       posteddate: e['PostedDate'],
                                              //     ),
                                              //   ),
                                              // );

                                              await Auth_services()
                                                  .studentAttendance(
                                                e['DocId'],
                                                userdata['uid'],
                                                userdata['Name'],
                                                userdata['Rollno'],
                                                userdata['Class'],
                                                formattedDate,
                                                e['Title'],
                                                e['Subject'],
                                                e['PostedBy'],
                                                e['PostedDate'],
                                              );
                                              meetingController
                                                  .setCurrentMeetngId(
                                                      e['DocId']);

                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return MeetingWidget(
                                                        meetingId: e['MeetID'],
                                                        meetingPassword:
                                                            e['Pass']);
                                                  },
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
    );
  }
}
