import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Exam/quiz.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/teacher/quizDesc.dart';
import 'package:school_management/teacher/studentQuiz.dart';
import 'package:school_management/teacher/uploadquiz.dart';

class QuizTeacher extends StatefulWidget {
  @override
  _QuizTeacherState createState() => _QuizTeacherState();
}

class _QuizTeacherState extends State<QuizTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Auth_services().getAllQuiz(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs
                      .map(
                        (e) => userdata['uid'] == e['Tid']
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Title: ' + e['Quiz_Title'],
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
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
                                              "Assigned by: " +
                                                  e['Posted_By'] +
                                                  " on " +
                                                  e['Posted_Date']
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Subject: ' + e['Subject'],
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              e['Mcq'].toString() == "true"
                                                  ? "Type: MCQ"
                                                  : "Type: Theory",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Due: ' + e['Due'],
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          TQuizDesc(
                                                    desc: e['Quiz_Des'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('View Description'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Do you want to delete this assignment?"),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          Auth_services()
                                                              .deleteQuiz(e);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Text('Delete '),
                                                Icon(Icons.delete),
                                              ],
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          StudentQuizView(
                                                              quizId:
                                                                  e['Quiz_ID']),
                                                ),
                                              );
                                            },
                                            child:
                                                Text('Quiz given by students'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => UploadQuiz(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: getcolor(),
      ),
    );
  }
}
