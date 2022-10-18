import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/zoom/meeting_screen.dart';
import 'package:school_management/zoom/start_meeting_screen.dart';
import 'package:intl/intl.dart';

class JoinWidget extends StatefulWidget {
  final String documentId, subject, title, postedby, posteddate;
  const JoinWidget(
      {Key key,
      this.documentId,
      this.subject,
      this.title,
      this.postedby,
      this.posteddate})
      : super(key: key);
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  DateTime curdate = DateTime.now();
  String formattedDate;
  final _formkey = GlobalKey<FormState>();
  Auth_services _auth_services = Auth_services();
  TextEditingController meetingIdController = TextEditingController();
  TextEditingController meetingPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curdate);
  }

  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Meetings'),
        titleSpacing: 2,
        centerTitle: true,
        backgroundColor: getcolor(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 32.0,
            ),
            child: Column(
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter ID";
                            } else {
                              return null;
                            }
                          },
                          controller: meetingIdController,
                          onChanged: (v) => meetingIdController.text = v,
                          decoration: InputDecoration(
                            labelText: 'Meeting ID',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter password";
                            } else {
                              return null;
                            }
                          },
                          controller: meetingPasswordController,
                          onChanged: (v) => meetingPasswordController.text = v,
                          decoration: InputDecoration(
                            labelText: 'Meeting Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Builder(
                          builder: (context) {
                            // The basic Material Design action button.
                            return RaisedButton(
                              // If onPressed is null, the button is disabled
                              // this is my goto temporary callback.
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  await _auth_services.studentAttendance(
                                    widget.documentId,
                                    userdata['uid'],
                                    userdata['Name'],
                                    userdata['Rollno'],
                                    userdata['Class'],
                                    formattedDate,
                                    widget.title,
                                    widget.subject,
                                    widget.postedby,
                                    widget.posteddate,
                                  );
                                  joinMeeting(context);
                                }
                              },
                              child: Text('Join'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      // The basic Material Design action button.
                      return RaisedButton(
                        // If onPressed is null, the button is disabled
                        // this is my goto temporary callback.
                        onPressed: () => startMeeting(context),
                        child: Text('Start Meeting'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MeetingWidget(
              meetingId: meetingIdController.text,
              meetingPassword: meetingPasswordController.text);
        },
      ),
    );
  }

  startMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StartMeetingWidget(meetingId: meetingIdController.text);
        },
      ),
    );
  }
}
