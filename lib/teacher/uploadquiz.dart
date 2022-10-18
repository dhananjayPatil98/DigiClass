import 'dart:async';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/teacher/addQuestion.dart';

class UploadQuiz extends StatefulWidget {
  @override
  _UploadQuizState createState() => _UploadQuizState();
}

class _UploadQuizState extends State<UploadQuiz> {
  final _formkey = GlobalKey<FormState>();
  bool ismcq;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Auth_services _authServices = Auth_services();
  DateTime curdate = DateTime.now();
  String formattedDate;
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _sub = TextEditingController();
  TextEditingController _class = TextEditingController();
  TextEditingController _date = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curdate);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'CREATE QUIZ',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white12,
        elevation: 0,
        titleSpacing: 1.0,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      print(val);
                      return null;
                    },
                    controller: _title,
                    decoration: InputDecoration(
                      hintText: 'Quiz Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: _desc,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: 'Quiz Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      print(value);
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: _sub,
                    decoration: InputDecoration(
                      hintText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      print(value);
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: _class,
                    decoration: InputDecoration(
                      hintText: 'Class',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      print(value);
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    icon: Flexible(
                      child: Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                    ),
                    hint: Text("MCQ's"),
                    items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String value) async {
                      debugPrint(value);
                      if (value == 'Yes') {
                        setState(() {
                          ismcq = true;
                        });
                      } else if (value == 'No') {
                        setState(
                          () {
                            ismcq = false;
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: DateTimePicker(
                    controller: _date,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Due date',
                    ),
                    type: DateTimePickerType.dateTime,
                    dateMask: 'dd/MM/yyyy',
                    firstDate: DateTime(1960),
                    lastDate: DateTime(2100),
                    calendarTitle: "Birthdate",
                    confirmText: "Confirm",
                    enableSuggestions: true,
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: getcolor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        try {
                          String docId = await _authServices.tCreateQuiz(
                              _title.text,
                              _desc.text,
                              _sub.text,
                              _class.text.toUpperCase(),
                              _date.text,
                              formattedDate,
                              userdata['Name'],
                              userdata['uid'],
                              ismcq);
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Quiz Created...'),
                              backgroundColor: Colors.green[400],
                            ),
                          );
                          print(docId);
                          Timer(
                            Duration(seconds: 3),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TaddQuizQue(
                                    docId: docId,
                                    ismcq: ismcq,
                                  ),
                                ),
                              );
                            },
                          );
                        } catch (e) {
                          debugPrint(e);
                        }
                      }
                    },
                    child: Text(
                      'Create Quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
