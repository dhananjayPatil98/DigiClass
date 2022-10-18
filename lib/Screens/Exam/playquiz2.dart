import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/getimage.dart';

class PlayQuiz2 extends StatefulWidget {
  final String quizId;

  final bool type;
  const PlayQuiz2({Key key, @required this.quizId, subject, this.type})
      : super(key: key);

  @override
  _PlayQuiz2State createState() => _PlayQuiz2State();
}

class _PlayQuiz2State extends State<PlayQuiz2> {
  Auth_services _auth_services = Auth_services();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<File> fileList = [];
  String text, formattedDate;
  DateTime curDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curDate);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white12,
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: Auth_services().getQuizQuestion(widget.quizId),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, dynamic>> datas = [];
                  for (var item in snapshot.data.docs) {
                    datas.add(item.data());
                  }
                  return Column(
                    children: datas.map((e) {
                      debugPrint("Index : $e");
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(Q)   ' + e['Question'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Text(fileList[datas.indexOf(e) + 1].path),
                                fileList.length >= datas.indexOf(e) + 1
                                    ? Text(
                                        "Uploaded : ${fileList[datas.indexOf(e)].path.split("/").last}")
                                    : Text("Upload"),

                                // Text(fileList.isEmpty
                                //     ? 'Upload a File'
                                //     : 'Uploaded File: ' +
                                //         fileList[
                                //                 snapshot.data.docs.indexOf(e) + 1]
                                //             .path
                                //             .split("/")
                                //             .last),
                                fileList.length >= datas.indexOf(e) + 1
                                    ? OutlinedButton(
                                        onPressed: () async {
                                          fileList.clear();
                                          setState(() {});
                                        },
                                        child: Text('Clear'),
                                      )
                                    : OutlinedButton(
                                        onPressed: () async {
                                          String path =
                                              await getMultipleFileSelected();
                                          debugPrint(path);

                                          fileList.add(
                                            File(path),
                                          );
                                          setState(() {});
                                        },
                                        child: Text('Upload'),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            try {
              await _auth_services.quizTheoryStudent(
                  widget.quizId, fileList, formattedDate, widget.type);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Home(),
                ),
              );
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Quiz Submitted'),
                  backgroundColor: Colors.green[400],
                ),
              );
            } catch (e) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Quiz Submitted'),
                  backgroundColor: Colors.red[400],
                ),
              );
            }
          },
          label: Text(
            "SUBMIT",
            style: TextStyle(fontSize: 18, letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
