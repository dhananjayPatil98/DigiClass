import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';

class ViewStudAttend extends StatefulWidget {
  final String docId;
  const ViewStudAttend({Key key, this.docId}) : super(key: key);
  @override
  _ViewStudAttendState createState() => _ViewStudAttendState();
}

class _ViewStudAttendState extends State<ViewStudAttend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attended Meetings'),
        titleSpacing: 2,
        centerTitle: true,
        backgroundColor: getcolor(),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: Auth_services().getMeetStudentAttendance(widget.docId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                print(snapshot);
                return Column(
                  children: snapshot.data.docs
                      .map((e) => Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.zero,
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Name: ' + e['Name'],
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Roll No: ' + e['RollNo'],
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
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
                                          'Meet Joined At: ' + e['MeetJoined'],
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
                                      Flexible(
                                        child: Text(
                                          'Meet closed At: ' + e['MeetLeave'],
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
                                      Flexible(
                                        child: Text(
                                          e['Attended'] == true
                                              ? "Present"
                                              : "Abscent",
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              }
              return Container(
                  child: Column(
                children: [CircularProgressIndicator(), Text('hello')],
              ));
            },
          ),
        ),
      ),
    );
  }
}
