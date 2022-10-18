import 'package:flutter/material.dart';
import 'package:school_management/services/currentuser.dart';

Color getcolor() {
  if (userdata["isTeacher"] == 'false') {
    return Colors.blue;
  } else if (userdata["isTeacher"] == 'true') {
    return Colors.green;
  } else {
    return null;
  }
}
