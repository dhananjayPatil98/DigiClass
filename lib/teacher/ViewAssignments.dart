import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/getcolor.dart';

class viewAssignments extends StatefulWidget {
  final String assignmentId;

  const viewAssignments({Key key, @required this.assignmentId})
      : super(key: key);
  @override
  _viewAssignmentsState createState() => _viewAssignmentsState();
}

class _viewAssignmentsState extends State<viewAssignments> {
  Auth_services auth_services = Auth_services();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint("${widget.assignmentId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Assignments'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: Auth_services().getAlluserAssignments(widget.assignmentId),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              debugPrint("${snapshot.data.docs.length}");
              return Column(
                children: snapshot.data.docs
                    .map(
                      (e) => Card(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      e['Name'],
                                      style: TextStyle(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'RollNo: ' + e['Rollno'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18),
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
                                      'Submitted on: ',
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'File: ' + e['docName'],
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      File file = await auth_services
                                          .downloadFile(e['Url'], e['docName']);
                                      print("Stored PDF: ${file.path}");
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Download'),
                                            Icon(
                                              Icons.download_outlined,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return CircularProgressIndicator();
          }),
    );
  }
}
