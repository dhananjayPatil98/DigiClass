import 'package:flutter/material.dart';
import 'package:school_management/Widgets/Attendance/OverAllAttendanceCard.dart';

class OverallAttendance extends StatefulWidget {
  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OverallAttendanceCard(),
          ],
        ),
      ),
    );
  }
}
