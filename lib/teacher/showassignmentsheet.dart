import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:intl/intl.dart';

class Showassignmentsheet extends StatefulWidget {
  @override
  _ShowassignmentsheetState createState() => _ShowassignmentsheetState();
}

class _ShowassignmentsheetState extends State<Showassignmentsheet> {
  final _formkey = GlobalKey<FormState>();
  DateTime curUser = DateTime.now();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Auth_services auth_services = Auth_services();
  TextEditingController sub = TextEditingController();
  TextEditingController subclass = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController desp = TextEditingController();
  StateSetter _setState;
  String formattedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StatefulBuilder(
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Text(
                'Enter Assignments details',
                style: TextStyle(fontSize: 25),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 20, 8, 0),
                      child: TextFormField(
                        controller: sub,
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
                        controller: title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Assignment title or number',
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
                        controller: subclass,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 10, 8, 0),
                      child: TextFormField(
                        maxLines: 10,
                        controller: desp,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Description',
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
                      child: DateTimePicker(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Set due date for assignments',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        type: DateTimePickerType.date,
                        dateMask: 'dd/MM/yyyy',
                        controller: date,
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2100),
                        calendarTitle: "Birthdate",
                        confirmText: "Confirm",
                        enableSuggestions: true,
                        onChanged: (val) => print(val),
                        validator: (val) {
                          if (val.isEmpty) {
                            print('This field cannot be empty');
                          }
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: getcolor(),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            try {
                              await auth_services.addassignment(
                                userdata['uid'],
                                sub.text,
                                title.text,
                                subclass.text.toUpperCase(),
                                date.text,
                                userdata['Name'],
                                desp.text,
                                formattedDate.split('').first,
                              );
                              Navigator.pop(context);
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('Assignment created'),
                                  backgroundColor: Colors.red[400],
                                ),
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
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
