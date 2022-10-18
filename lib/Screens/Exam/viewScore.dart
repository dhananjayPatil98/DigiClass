import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';

class ViewScore extends StatefulWidget {
  @override
  _ViewScoreState createState() => _ViewScoreState();
}

class _ViewScoreState extends State<ViewScore> {
  Auth_services _auth_services = Auth_services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Report'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: Auth_services().getStudentExamReport2(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  print(snapshot);
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map(
                            (e) => e['Mcq'] == true
                                ? userdata['uid'] == e['StudentId']
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Subject: ' +
                                                          e['Subject'],
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Submitted On: ' +
                                                          e['SubmitedOn']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Correct: ' +
                                                          e['Correct']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "Incorrect: " +
                                                          e['Incorrect']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
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
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Not Attempted: ' +
                                                          e['NotAttempted']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container()
                                : Container(),
                          )
                          .toList(),
                    );
                  }
                  return Container();
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Auth_services().getAllTeacherReport(),
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
                                            'Subject: ' + e['Subject'],
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
                                                  'Posted by: ' + e['postedBy'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'Date: ' +
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
                                                  print(e['notesDocs']);
                                                  print(e['docName']);
                                                  File file =
                                                      await _auth_services
                                                          .downloadFile(
                                                              e['notesDocs'],
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
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
