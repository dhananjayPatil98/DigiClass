import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/getcolor.dart';

class StudentQuizView extends StatefulWidget {
  final String quizId;

  const StudentQuizView({Key key, this.quizId}) : super(key: key);
  @override
  _StudentQuizViewState createState() => _StudentQuizViewState();
}

class _StudentQuizViewState extends State<StudentQuizView> {
  DateTime curdate = DateTime.now();
  String formattedDate;
  downloadAllFile(List<String> urlList, List<String> nameList) async {
    List<String> data = [
      "https://firebasestorage.googleapis.com/v0/b/digi-class-dcab5.appspot.com/o/Quiz%2FStudent%2Faf3EIOtzMzUmVJRQgZSYw0v7GzX2%2Fe0t02PhJK01V8hNwdw1x%2Fsampldsfe.pdf?alt=media&token=c8839e45-3a5e-4e5b-adda-7456506d00d3",
      "https://firebasestorage.googleapis.com/v0/b/digi-class-dcab5.appspot.com/o/Quiz%2FStudent%2Faf3EIOtzMzUmVJRQgZSYw0v7GzX2%2Fe0t02PhJK01V8hNwdw1x%2Fsampldsfe.pdf?alt=media&token=c8839e45-3a5e-4e5b-adda-7456506d00d3"
    ];

    List<File> downloadedFilesList = [];

    for (var item in urlList) {
      File file = await Auth_services().downloadFile(
          item, "${urlList.indexOf(item)}-${nameList[urlList.indexOf(item)]}");
      downloadedFilesList.add(file);
      debugPrint(file.path);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curdate);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Report'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: Auth_services().getStudentExamReport1(widget.quizId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs
                      .map(
                        (e) => e['Mcq'] == true
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
                                              'Name: ' + e['StudentName'],
                                              style: TextStyle(fontSize: 20),
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
                                              'Submitted On: ' +
                                                  e['SubmitedOn'].toString(),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Correct: ' +
                                                  e['Correct'].toString(),
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "Incorrect: " +
                                                  e['Incorrect'].toString(),
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
                                              'Roll No: ' +
                                                  e['StudentRollNo'].toString(),
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Not Attempted: ' +
                                                  e['NotAttempted'].toString(),
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
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
                            : Card(
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
                                              'Subject: ' + e['StudentName'],
                                              style: TextStyle(fontSize: 20),
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
                                              'Submitted On: ' +
                                                  e['SubmitedOn'].toString(),
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
                                              'Roll No: ' + e['StudentRollNo'],
                                              style: TextStyle(fontSize: 20),
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
                                            onPressed: () {
                                              downloadAllFile(
                                                  e['Url'].cast<String>(),
                                                  e['FileName'].cast<String>());
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Download'),
                                                    Icon(Icons.file_download)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      )
                      .toList(),
                );
              } else {
                Container();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
