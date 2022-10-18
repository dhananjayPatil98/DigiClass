import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/services/getimage.dart';

class SviewAssignment extends StatefulWidget {
  final Map<String, dynamic> data;

  const SviewAssignment({Key key, @required this.data}) : super(key: key);
  @override
  _SviewAssignmentState createState() => _SviewAssignmentState();
}

class _SviewAssignmentState extends State<SviewAssignment> {
  List<File> fileList = [];
  Auth_services auth_services = Auth_services();
  DateTime curDate = DateTime.now();
  String formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Title: ' +
                        widget.data['Assignmentstitle']
                            .toString()
                            .toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Subject: ' +
                        widget.data['Subject'].toString().toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Class: ' + widget.data['Class'].toString().toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Due Date: ' +
                        widget.data['Duedate'].toString().toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Auth_services()
                    .getAssignmentsByUser(userdata['uid'], widget.data['id']),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData)
                    return Column(
                      children: snapshot.data.docs.length == 0
                          ? [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                    ),
                                    onPressed: () async {
                                      String path =
                                          await getMultipleFileSelected();
                                      fileList.add(
                                        File(path),
                                      );
                                    },
                                    child: Text(
                                      "Upload file",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: getcolor(),
                                    ),
                                    onPressed: () async {
                                      try {
                                        auth_services.addAssignmentToDb(
                                          userdata['uid'],
                                          userdata['Name'],
                                          userdata['Rollno'],
                                          userdata['Class'],
                                          fileList,
                                          widget.data['id'],
                                          formattedDate,
                                        );
                                        fileList.clear();
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "File Uploaded succefully"),
                                              actions: [
                                                TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        setState(() {});
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]
                          : snapshot.data.docs.map(
                              (e) {
                                var assignmentData = e.data();
                                return Column(
                                  children: [
                                    Text(
                                      'Uploaded File: ' +
                                          assignmentData['docName'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: getcolor(),
                                      ),
                                      onPressed: () async {
                                        try {
                                          Auth_services().sdeleteAssignment(e);
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("File Deleted"),
                                                actions: [
                                                  TextButton(
                                                    child: Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          setState(() {});
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                    );
                  return CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
