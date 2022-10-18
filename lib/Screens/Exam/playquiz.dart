import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/Screens/Exam/quizwidget.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/management/quiz.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:intl/intl.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId, subject;

  final bool type;
  const PlayQuiz({Key key, this.quizId, this.subject, this.type})
      : super(key: key);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Auth_services _auth_services = Auth_services();
  QuizController quizController = Get.put(QuizController());
  DateTime curDate = DateTime.now();
  String formattedDate;
  int total, notAttemnpted;
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
                  quizController.total = snapshot.data.size;
                  // quizController.notAttempted = snapshot.data.size;
                  quizController.setQuizDatas(snapshot.data);
                  // return Column(
                  //   children: snapshot.data.docs.map(
                  //     (e) {
                  //       debugPrint("e : ${e.data()}");
                  //       return SingleChildScrollView(
                  //         child: QuizWidget(
                  //           data: e,
                  //           total: quizController.total,
                  //           notAttempted: quizController.notAttempted,
                  //         ),
                  //       );
                  //     },
                  //   ).toList(),

                  // );
                  return SingleChildScrollView(
                    child: QuizWidget(),
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
              debugPrint("getdata.correct : ${quizController.correct}");
              await _auth_services.quizMcqStudent(
                  widget.quizId,
                  quizController.correct,
                  quizController.getnotAttempted(),
                  quizController.incorrect,
                  formattedDate,
                  widget.subject,
                  widget.type);
              quizController.reset();
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
              setState(() {});
            } catch (e) {
              Navigator.pop(context);
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(e),
                  backgroundColor: Colors.red[400],
                ),
              );
            }
          },
          label: Text(
            'SUBMIT',
            style: TextStyle(fontSize: 18, letterSpacing: 2.0),
          ),
          icon: Icon(Icons.check),
        ),
      ),
    );
  }
}
