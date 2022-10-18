import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/services/getimage.dart';

class TeacherNotes extends StatefulWidget {
  @override
  _TeacherNotesState createState() => _TeacherNotesState();
}

class _TeacherNotesState extends State<TeacherNotes> {
  final DateTime curdate = DateTime.now();
  String formattedDate;
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curdate);
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Auth_services auth_services = Auth_services();
  final _formkey = GlobalKey<FormState>();
  List<File> fileList = [];
  showThisDialog() {
    StateSetter _setState;
    TextEditingController text = TextEditingController();
    TextEditingController sub_class = TextEditingController();

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              _setState = setState;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            fileList.clear();
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Text(
                    'Enter Notes details',
                    style: TextStyle(fontSize: 25),
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9, 10, 8, 0),
                          child: TextFormField(
                            controller: text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Subject',
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'This field cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9, 10, 8, 0),
                          child: TextFormField(
                            controller: sub_class,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Class',
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'This field cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          onPressed: () async {
                            String path = await getMultipleFileSelected();
                            _setState(
                              () {
                                fileList.add(File(path));
                              },
                            );
                          },
                          child: Text(
                            "Add File",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: getcolor(),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              try {
                                auth_services.addNotesToDb(
                                    userdata['uid'],
                                    text.text,
                                    sub_class.text.toUpperCase(),
                                    fileList,
                                    userdata['Name'],
                                    formattedDate);
                                fileList.clear();
                                Navigator.pop(context);
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Notes Uploaded'),
                                    backgroundColor: Colors.green[400],
                                  ),
                                );
                                setState(() {});
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
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: fileList
                          .map((e) => Text(
                                "Selected File: " + e.path.split('/').last,
                                style: TextStyle(fontSize: 20),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: Auth_services().getAllNotes(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs
                      .map(
                        (e) => userdata['uid'] == e['userId']
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
                                      Text(
                                        'Subject: ' + e['notesTitle'],
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
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
                                              'Posted by: ' + e['postedBy'],
                                              style: TextStyle(fontSize: 15),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Date: ' +
                                                  e['date']
                                                      .toString()
                                                      .split(' ')
                                                      .first,
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
                                              'File: ' + e['docName'],
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
                                          OutlinedButton(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Download'),
                                                    Icon(Icons
                                                        .download_outlined),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            onPressed: () async {
                                              print(e['notesDocs']);
                                              print(e['docName']);
                                              File file = await auth_services
                                                  .downloadFile(e['notesDocs'],
                                                      e['docName']);
                                              print("Stored PDF: ${file.path}");
                                            },
                                          ),
                                          OutlinedButton(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Delete'),
                                                    Icon(Icons.close_rounded),
                                                  ],
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Do you want to delete this file"),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          Auth_services()
                                                              .deleteNotes(e);
                                                          Navigator.pop(
                                                              context);
                                                          _scaffoldKey
                                                              .currentState
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  'File deleted'),
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      400],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("No"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
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
                      .toList(),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showThisDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: getcolor(),
      ),
    );
  }
}

class DialogShowFile extends StatefulWidget {
  final List<File> fileList;
  final Function onAddFileClicked;
  const DialogShowFile(
      {Key key, @required this.fileList, @required this.onAddFileClicked})
      : super(key: key);
  @override
  _DialogShowFileState createState() => _DialogShowFileState();
}

class _DialogShowFileState extends State<DialogShowFile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children:
              widget.fileList.map((e) => Text(e.path.split('/').last)).toList(),
        ),
        TextButton(onPressed: widget.onAddFileClicked, child: Text("Add File"))
      ],
    );
  }
}
/**/
