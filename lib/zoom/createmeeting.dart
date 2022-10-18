import 'dart:async';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:intl/intl.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final _formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Auth_services _authServices = Auth_services();
  DateTime curdate = DateTime.now();
  String formattedDate;
  TextEditingController _id = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _sub = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _due = TextEditingController();
  TextEditingController _class = TextEditingController();
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
        title: Text('Create Meet'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Title',
                      contentPadding: EdgeInsets.all(5),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    controller: _title,
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Subject',
                      contentPadding: EdgeInsets.all(5),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    controller: _sub,
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Class',
                      contentPadding: EdgeInsets.all(5),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    controller: _class,
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: DateTimePicker(
                    controller: _due,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter ID',
                      contentPadding: EdgeInsets.all(5),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    controller: _id,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      } else if ((Fzregex.hasMatch(
                              val, FzPattern.numericOnly) ==
                          false)) {
                        return 'Enter a valid ID';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter password',
                      contentPadding: EdgeInsets.all(5),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    controller: _pass,
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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: OutlinedButton(
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        try {
                          await _authServices.createMeetingData(
                            _id.text,
                            _pass.text,
                            _sub.text,
                            _title.text,
                            _class.text.toUpperCase(),
                            _due.text,
                            formattedDate,
                            userdata['Name'],
                            userdata['uid'],
                          );
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Meet Created'),
                              backgroundColor: Colors.green[400],
                            ),
                          );
                          Timer(Duration(seconds: 3), () {
                            Navigator.pop(context);
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
                    child: Text('Create'),
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
