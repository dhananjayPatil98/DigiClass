import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/teacher/thome.dart';

class TaddQuizQue extends StatefulWidget {
  final String docId;
  final bool ismcq;
  const TaddQuizQue({Key key, @required this.docId, @required this.ismcq})
      : super(key: key);
  @override
  _TaddQuizQueState createState() => _TaddQuizQueState();
}

class _TaddQuizQueState extends State<TaddQuizQue> {
  final _formkey = GlobalKey<FormState>();
  final Auth_services _authServices = Auth_services();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _que = TextEditingController();
  TextEditingController _option1 = TextEditingController();
  TextEditingController _option2 = TextEditingController();
  TextEditingController _option3 = TextEditingController();
  TextEditingController _option4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Question',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white12,
        elevation: 0,
        titleSpacing: 1.0,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: widget.ismcq == true
              ? Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            print(value);
                            return null;
                          },
                          controller: _que,
                          decoration: InputDecoration(
                            hintText: 'Question',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            print(value);
                            return null;
                          },
                          controller: _option1,
                          decoration: InputDecoration(
                            hintText: 'Option 1(Correct Option)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            print(value);
                            return null;
                          },
                          controller: _option2,
                          decoration: InputDecoration(
                            hintText: 'Option 2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            print(value);
                            return null;
                          },
                          controller: _option3,
                          decoration: InputDecoration(
                            hintText: 'Option 3',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            print(value);
                            return null;
                          },
                          controller: _option4,
                          decoration: InputDecoration(
                            hintText: 'Option 4',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: getcolor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 15),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  try {
                                    await _authServices.taddQuizMcqQues(
                                      _que.text,
                                      _option1.text,
                                      _option2.text,
                                      _option3.text,
                                      _option4.text,
                                      widget.docId,
                                    );

                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Question Added'),
                                        backgroundColor: Colors.green[400],
                                      ),
                                    );
                                    setState(() {
                                      _que.clear();
                                      _option1.clear();
                                      _option2.clear();
                                      _option3.clear();
                                      _option4.clear();
                                    });
                                  } catch (e) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(e),
                                        backgroundColor: Colors.red[400],
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Add Question',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: getcolor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 15),
                              ),
                              onPressed: () async {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Questions Added'),
                                    backgroundColor: Colors.green[400],
                                  ),
                                );
                                Timer(
                                  Duration(seconds: 4),
                                  () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            tHome(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            print(value);
                            return null;
                          },
                          controller: _que,
                          decoration: InputDecoration(
                            hintText: 'Question',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Text(
                          'Upload File',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: getcolor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 15),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  try {
                                    await _authServices.addQuizTheoryQuestions(
                                        widget.docId, _que.text);

                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Question Added'),
                                        backgroundColor: Colors.green[400],
                                      ),
                                    );
                                    setState(
                                      () {
                                        _que.clear();
                                      },
                                    );
                                  } catch (e) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(e),
                                        backgroundColor: Colors.red[400],
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Add Question',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: getcolor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 15),
                              ),
                              onPressed: () async {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Questions Added'),
                                    backgroundColor: Colors.green[400],
                                  ),
                                );
                                Timer(
                                  Duration(seconds: 4),
                                  () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            tHome(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
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
