import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:fzregex/fzregex.dart';
import 'package:school_management/services/Auth_services.dart';
import 'dart:async';
import 'package:school_management/services/getcolor.dart';

class sprofilemodal extends StatefulWidget {
  @override
  _sprofilemodalState createState() => _sprofilemodalState();
}

class _sprofilemodalState extends State<sprofilemodal> {
  TextEditingController _name = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _mob = TextEditingController();
  TextEditingController _roll = TextEditingController();
  TextEditingController _address = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Auth_services _auth = Auth_services();
  String selectedGender = "Male", flag1, flag2, flag3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
          child: StreamBuilder(
              stream: _auth.getCurrentUserStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> suserdata = snapshot.data.data();
                  if (suserdata["isTeacher"] == "false") {
                    flag1 = 'Rollno';
                    flag2 = suserdata['Rollno'];
                  } else {
                    flag1 = 'Teacher id';
                    flag2 = suserdata['Teacher id'];
                  }
                  return Form(
                    key: _formkey,
                    child: Stack(
                      children: [
                        IconButton(
                            alignment: Alignment.topLeft,
                            iconSize: 25,
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                          child: Text('Name'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: suserdata['Name'],
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            controller: _name,
                            validator: (value) {
                              RegExp nameRegExp = RegExp('[a-zA-Z]');
                              RegExp numberRegExp = RegExp(r'\d');
                              if (value.isEmpty) {
                                _name.text = suserdata["Name"];
                                return null;
                              } else if (nameRegExp.hasMatch(value) == false) {
                                return 'Enter Vaild name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 160, 10, 0),
                          child: Text('Mobile No'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 180, 190, 0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: suserdata['PhoneNo'],
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            controller: _mob,
                            validator: (value) {
                              if (value.isEmpty) {
                                _mob.text = suserdata["PhoneNo"];
                                return null;
                              } else if (Fzregex.hasMatch(
                                  value, FzPattern.phone)) {
                                return 'Enter Valid Mobile number';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 160, 10, 0),
                          child: Text(flag1),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 180, 10, 0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: flag2,
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            controller: _roll,
                            validator: (value) {
                              if (value.isEmpty) {
                                _roll.text = flag2;
                                return null;
                              } else if (suserdata['isTeacher'] == 'false' &&
                                  Fzregex.hasMatch(
                                          value, FzPattern.numericOnly) ==
                                      false) {
                                return "Invalid Roll Number";
                              } else if (suserdata['isTeacher'] == 'true' &&
                                  Fzregex.hasMatch(value, FzPattern.username) ==
                                      false) {
                                return "Invalid Roll Number";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 260, 10, 0),
                          child: Text('Birthdate'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 280, 190, 0),
                          child: DateTimePicker(
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: suserdata['Birthdate'],
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            type: DateTimePickerType.date,
                            dateMask: 'dd/MM/yyyy',
                            controller: _date,
                            //initialValue: _initialValue,
                            firstDate: DateTime(1960),
                            lastDate: DateTime(2100),
                            calendarTitle: "Birthdate",
                            confirmText: "Confirm",
                            enableSuggestions: true,
                            onChanged: (val) => print(val),
                            validator: (val) {
                              if (val.isEmpty) {
                                _date.text = suserdata["Birthdate"];
                              }
                              print(val);
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 260, 10, 0),
                          child: Text('Gender'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220, 280, 10, 0),
                          child: DropdownButtonFormField(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: suserdata['Gender'],
                                hintStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              value: selectedGender,
                              onChanged: (val) {
                                setState(() {
                                  if (val.isEmpty)
                                    selectedGender = suserdata['Gender'];
                                  else
                                    selectedGender = val;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text("Male"),
                                  value: "Male",
                                ),
                                DropdownMenuItem(
                                  child: Text("Female"),
                                  value: "Female",
                                ),
                                DropdownMenuItem(
                                  child: Text("Other"),
                                  value: "Other",
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 360, 10, 0),
                          child: Text('Address'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 380, 10, 0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: suserdata['Address'],
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            controller: _address,
                            validator: (value) {
                              if (value.isEmpty) {
                                _address.text = suserdata["Address"];
                                return null;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(130, 520, 130, 0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: getcolor(),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                dynamic result = await _auth.updateuser(
                                    _name.text,
                                    _mob.text,
                                    _roll.text,
                                    _date.text,
                                    selectedGender,
                                    _address.text);
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Profile Updated. Loading.......',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Timer(Duration(seconds: 3), () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Text(
                              "Save Changes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              })),
    );
  }
}
