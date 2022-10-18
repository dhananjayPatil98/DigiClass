import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Leave_Apply/LeaveHistory.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/getcolor.dart';

class LeaveApply extends StatefulWidget {
  @override
  _LeaveApplyState createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  TextEditingController _date1 = TextEditingController();
  TextEditingController _date2 = TextEditingController();
  TextEditingController msg = TextEditingController();
  String selectleavetype;
  Auth_services auth_services = Auth_services();

  final searchFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Apply Leave'),
            centerTitle: true,
            backgroundColor: getcolor(),
            elevation: 0.0,
          ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: Colors.black.withOpacity(0.5),
                      height: 1,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          muchDelayedAnimation.value * width, 0, 0),
                      child: Text(
                        "Choose Leave Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: DropdownButtonFormField(
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Please Select Leave Type",
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          value: selectleavetype,
                          onChanged: (val) {
                            setState(() {
                              if (val.isEmpty)
                                return 'Enter leave date';
                              else
                                selectleavetype = val;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              child: Text("Medical"),
                              value: "Medical",
                            ),
                            DropdownMenuItem(
                              child: Text("Family"),
                              value: "Family",
                            ),
                            DropdownMenuItem(
                              child: Text("Function"),
                              value: "Function",
                            ),
                            DropdownMenuItem(
                              child: Text("Other"),
                              value: "Other",
                            )
                          ]),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          muchDelayedAnimation.value * width, 0, 0),
                      child: Text(
                        "Leave Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 13,
                      ),
                      child: Container(
                        // height: height * 0.06,
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  width: width * 0.28,
                                  decoration: BoxDecoration(
                                      color: Colors.white38,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: Colors.black26,
                                        )
                                      ]),
                                  child: DateTimePicker(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From',
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    type: DateTimePickerType.date,
                                    dateMask: 'dd/MM/yyyy',
                                    controller: _date1,
                                    firstDate: DateTime(1960),
                                    lastDate: DateTime(2100),
                                    calendarTitle: "Birthdate",
                                    confirmText: "Confirm",
                                    enableSuggestions: true,
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Pick a date';
                                      }
                                      print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  width: width * 0.28,
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        color: Colors.black26,
                                      )
                                    ],
                                  ),
                                  child: DateTimePicker(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To',
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    type: DateTimePickerType.date,
                                    dateMask: 'dd/MM/yyyy',
                                    controller: _date2,
                                    firstDate: DateTime(1960),
                                    lastDate: DateTime(2100),
                                    calendarTitle: "Birthdate",
                                    confirmText: "Confirm",
                                    enableSuggestions: true,
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Pick a date';
                                      }
                                      print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          muchDelayedAnimation.value * width, 0, 0),
                      child: Text(
                        "Apply Leave Reason",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 13,
                        ),
                        child: Container(
                          height: height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: msg,
                            minLines: 1,
                            maxLines: 10,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: Bouncing(
                        onPress: () {
                          if (_formkey.currentState.validate()) {
                            auth_services.addleave(selectleavetype, _date1.text,
                                _date2.text, msg.text);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Leave Submitted',
                                  style: TextStyle(fontSize: 15),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        child: Container(
                          //height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Request Leave",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: Bouncing(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LeaveHistory(),
                            ),
                          );
                        },
                        child: Container(
                          //height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "View Leave History",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
