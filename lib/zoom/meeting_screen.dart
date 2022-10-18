import 'dart:async';
import 'dart:io';
import 'package:flutter_zoom_plugin/zoom_view.dart';
import 'package:flutter_zoom_plugin/zoom_options.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:school_management/management/meeting.dart';
import 'package:school_management/services/Auth_services.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';

class MeetingWidget extends StatelessWidget {
  ZoomOptions zoomOptions;
  ZoomMeetingOptions meetingOptions;

  Timer timer;

  MeetingWidget({Key key, meetingId, meetingPassword}) : super(key: key) {
    this.zoomOptions = new ZoomOptions(
      domain: "zoom.us",
      appKey: "nhPNIR67tX2G7jwwQ6ZFi7VSfZZBAGmLPhcw",
      appSecret: "BgjHtDbWEyThyEZyKrHFHcHR9z430xQvAsgc",
    );
    this.meetingOptions = new ZoomMeetingOptions(
        userId: userdata['Name'],
        meetingId: meetingId,
        meetingPassword: meetingPassword,
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false");
  }

  bool _isMeetingEnded(String status) {
    var result = false;
    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }

  DateTime curdate = DateTime.now();
  String formattedDate;
  String leavedate;
  void initState() {
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(curdate);
  }

  @override
  Widget build(BuildContext context) {
    MeetingController meetingController = Get.put(MeetingController());
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading meeting '),
        centerTitle: true,
        backgroundColor: getcolor(),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ZoomView(onViewCreated: (controller) {
            print("Created the view");

            controller.initZoom(this.zoomOptions).then((results) {
              print("initialised");
              print(results);

              if (results[0] == 0) {
                controller.zoomStatusEvents.listen((status) {
                  if (status[0] == "MEETING_STATUS_DISCONNECTING") {
                    Auth_services().updatemeetLeave(
                        meetingController.currentMeetingId, curdate);
                    debugPrint(
                        "Meeting Closed : $curdate"); //isko update karna hia
                  } //Call kar
                  print("Meeting Status Stream: " +
                      status[0] +
                      " - " +
                      status[1]);
                  if (_isMeetingEnded(status[0])) {
                    Navigator.pop(context);
                    timer?.cancel();
                  }
                });

                print("listen on event channel");

                controller
                    .joinMeeting(this.meetingOptions)
                    .then((joinMeetingResult) {
                  timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                    controller
                        .meetingStatus(this.meetingOptions.meetingId)
                        .then((status) {
                      print("Meeting Status Polling: " +
                          status[0] +
                          " - " +
                          status[1]);
                    });
                  });
                });
              }
            }).catchError((error) {
              print("Error");
              print(error);
            });
          })),
    );
  }
}
