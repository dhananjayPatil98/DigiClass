import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Assignments/description.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/teacher/showassignmentsheet.dart';
import 'package:school_management/teacher/ViewAssignments.dart';

class Teacherassignment extends StatefulWidget {
  @override
  _TeacherassignmentState createState() => _TeacherassignmentState();
}

class _TeacherassignmentState extends State<Teacherassignment> {
  Auth_services auth_services = Auth_services();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Auth_services().getAllassignments(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.docs
                    .map(
                      (e) => userdata['uid'] == e['UserId']
                          ? Card(
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
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Title: ' + e['Assignmentstitle'],
                                            style: TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Assigned by: name on date',
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
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Descriptio(
                                                  clas: e['id'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text('View description'),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Do you want to delete this assignment?"),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Yes"),
                                                      onPressed: () {
                                                        Auth_services()
                                                            .deleteAssignment(
                                                                e['id'], e);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("No"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text('Delete'),
                                              Icon(Icons.delete)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        viewAssignments(
                                                  assignmentId: e['id'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text('View'),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              /**/
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Showassignmentsheet(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: getcolor(),
      ),
    );
  }
}
