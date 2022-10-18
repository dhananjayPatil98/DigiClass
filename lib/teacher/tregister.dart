import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/services/Auth_services.dart';
import 'dart:async';

class tregister extends StatefulWidget {
  @override
  _tregisterState createState() => _tregisterState();
}

class _tregisterState extends State<tregister>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _phno = TextEditingController();
  TextEditingController _class = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _ronllno = TextEditingController();
  TextEditingController _pass = TextEditingController();
  String _teach, teacher = 'No';

  bool passshow = false;
  final Auth_services _auth = Auth_services();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          body: ListView(
            children: <Widget>[
              IconButton(
                  alignment: Alignment.topLeft,
                  iconSize: 25,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Transform(
                transform: Matrix4.translationValues(
                    animation.value * width, 0.0, 0.0),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(70.0, 35.0, 0, 0),
                          child: Text(
                            'ID',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 10),
                child: Transform(
                  transform:
                      Matrix4.translationValues(LeftCurve.value * width, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _name,
                                  validator: (value) {
                                    RegExp nameRegExp = RegExp('[a-zA-Z]');
                                    RegExp numberRegExp = RegExp(r'\d');
                                    if (value.isEmpty) {
                                      return 'You Must enter your Name!';
                                    } else if (nameRegExp.hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter Vaild name';
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Enter your Teacher ID';
                                    } else if ((Fzregex.hasMatch(
                                            val, FzPattern.username) ==
                                        false)) {
                                      return 'Enter a Valid Teacher ID';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _ronllno,
                                  decoration: InputDecoration(
                                      labelText: 'Teacher ID',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _class,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'You Must enter your class!';
                                    } else if (Fzregex.hasMatch(
                                            value, FzPattern.username) ==
                                        false) {
                                      return 'Enter valid Class or department';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Class or Departement',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _email,
                                  validator: (value) {
                                    if ((Fzregex.hasMatch(
                                            value, FzPattern.email) ==
                                        false)) {
                                      return "Enter Vaild Email address";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: 'E-Mail',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Container(
                                      width: 332,
                                      child: DropdownButton(
                                        icon: Flexible(
                                          child: Icon(
                                            Icons.arrow_drop_down_outlined,
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ),
                                        hint: Row(
                                          children: [
                                            Text('Class Teacher '),
                                            Text(
                                              '(' + teacher + ')',
                                            ),
                                            SizedBox(
                                              width: 170,
                                            )
                                          ],
                                        ),
                                        items: <String>['Yes', 'No']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String value) async {
                                          debugPrint(value);
                                          if (value == 'Yes') {
                                            setState(() {
                                              value = 'Yes';
                                            });
                                            teacher = value;
                                          } else if (value == 'No') {
                                            setState(() {
                                              value = 'No';
                                            });
                                            teacher = value;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _phno,
                                  validator: (value) {
                                    String pattern =
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                    RegExp regExp = new RegExp(pattern);
                                    if (value.length == 0) {
                                      return 'Please enter mobile number';
                                    } else if (!regExp.hasMatch(value)) {
                                      return 'Please enter valid mobile number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Mobile Number',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _pass,
                                  obscuringCharacter: '*',
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Enter Vaild password";
                                    } else if (val.length <= 5) {
                                      return "Password is too Weak";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      suffix: passshow == false
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow = true;
                                                });
                                              },
                                              icon: Icon(Icons.lock_open),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow = false;
                                                });
                                              },
                                              icon: Icon(Icons.lock),
                                            ),
                                      labelText: 'Password',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                  obscureText: passshow == false ? true : false,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                child: Transform(
                  transform: Matrix4.translationValues(
                      muchDelayedAnimation.value * width, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Bouncing(
                          onPress: () async {
                            if (_formkey.currentState.validate()) {
                              _teach = 'true';
                              dynamic result = await _auth.tregister_user(
                                  _email.text,
                                  _pass.text,
                                  _name.text,
                                  _ronllno.text,
                                  _class.text.toUpperCase(),
                                  _phno.text,
                                  _teach,
                                  teacher);
                              if (result ==
                                  'The account already exists for that email.') {
                                print('checking...' + result);
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(result),
                                    backgroundColor: Colors.red[400],
                                  ),
                                );
                              } else {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Teacher Registered. Loading.......',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Timer(Duration(seconds: 4), () {
                                  Navigator.pop(context);
                                });
                              }
                            }
                          },
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 0.0,
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.green,
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
