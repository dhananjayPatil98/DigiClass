import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Exam/playquiz.dart';
import 'package:school_management/Screens/Exam/playquiz2.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/teacher/quizDesc.dart';

class StudentQuiz extends StatefulWidget {
  @override
  _StudentQuizState createState() => _StudentQuizState();
}

class _StudentQuizState extends State<StudentQuiz> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder(
            stream: Auth_services().getAllQuiz(),
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
                                                e['Mcq'].toString() == 'true'
                                                    ? 'MCQ'
                                                    : 'Theory',
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        TQuizDesc(
                                                      desc: e['Quiz_Des'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text('View Description'),
                                            ),
                                            FutureBuilder<QuerySnapshot>(
                                              future: Auth_services()
                                                  .finishedquiz(e['Quiz_ID']),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                print("data" +
                                                    snapshot.data.docs
                                                        .toString());
                                                if (snapshot.data.docs.length ==
                                                    0)
                                                  return OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              e['Mcq'] == true
                                                                  ? PlayQuiz(
                                                                      quizId: e[
                                                                          'Quiz_ID'],
                                                                      subject: e[
                                                                          'Subject'],
                                                                      type: e[
                                                                          'Mcq'],
                                                                    )
                                                                  : PlayQuiz2(
                                                                      quizId: e[
                                                                          'Quiz_ID'],
                                                                      subject: e[
                                                                          'Subject'],
                                                                      type: e[
                                                                          'Mcq'],
                                                                    ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text('Start Quiz'),
                                                  );
                                                else
                                                  return Text('Quiz completed');
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
                        .toList());
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
