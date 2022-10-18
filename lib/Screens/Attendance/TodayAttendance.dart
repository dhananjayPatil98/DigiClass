import 'package:flutter/material.dart';
import 'package:school_management/Widgets/Attendance/AttendanceCard.dart';

class MeetingAttendance extends StatefulWidget {
  @override
  _MeetingAttendanceState createState() => _MeetingAttendanceState();
}

class _MeetingAttendanceState extends State<MeetingAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AttendanceCard(),
          ],
        ),
      ),
    );
  }
}
