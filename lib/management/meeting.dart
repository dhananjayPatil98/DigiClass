import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeetingController extends GetxController {
  String currentMeetingId = "";
  setCurrentMeetngId(String id) {
    currentMeetingId = id;
    update();
  }
}
