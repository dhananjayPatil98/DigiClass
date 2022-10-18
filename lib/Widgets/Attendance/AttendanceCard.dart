import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';

class AttendanceCard extends StatefulWidget {
  final String starttime;
  final String endtime;
  final String subject;
  final String staff;
  final bool attendance;

  const AttendanceCard(
      {Key key,
      this.starttime,
      this.endtime,
      this.subject,
      this.staff,
      this.attendance})
      : super(key: key);

  @override
  _AttendanceCardState createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: Auth_services().getStudentAttendance(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map(
                            (e) => userdata['uid'] == e['StudentId']
                                ? Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Title: ' + e['Title'],
                                            style: TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Subject: ' + e['Subject'],
                                            style: TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Posted by: ' + e['PostedBy'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  ' At ' +
                                                      e['PostedDate']
                                                          .toString()
                                                          .split(' ')
                                                          .first,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  'Meet Joined At: ' +
                                                      e['MeetJoined'],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  'Meet closed At: ' +
                                                      e['MeetLeave'],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  e['Attended'] == true
                                                      ? "Present"
                                                      : "Abscent",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
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
        );
      },
    );
  }
}
