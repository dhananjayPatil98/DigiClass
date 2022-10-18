import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';

class viewstudentleave extends StatefulWidget {
  @override
  _viewstudentleaveState createState() => _viewstudentleaveState();
}

class _viewstudentleaveState extends State<viewstudentleave> {
  Auth_services auth_service = Auth_services();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Leave'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: StreamBuilder(
          stream: Auth_services().getStudentLeave(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Column(
                    children: snapshot.data.docs
                        .map(
                          (e) => userdata['ClassTeacher'] == "Yes"
                              ? Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(e['Name']),
                                    subtitle: Text('Type: ' + e['Type']),
                                    trailing: IconButton(
                                      icon: Icon(Icons.arrow_right_alt),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 40),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Student Name: ' +
                                                              e["Name"],
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 40),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Rollno: ' +
                                                              e["Rollno"],
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Text(
                                                          'Type: ' + e["Type"],
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 40),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Reason: ' +
                                                              e["Reason"],
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 40),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'From: ' + e["From"],
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        Text(
                                                          'To: ' + e["To"],
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                        .toList(),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
