// import 'dart:io';
// import "package:flutter/material.dart";
// import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart'
//     as FeatureFlagEnum;
// import 'package:jitsi_meet/jitsi_meet.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:school_management/services/currentuser.dart';

// class JoinMeetingScreen extends StatefulWidget {
//   @override
//   _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
// }

// class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
//   TextEditingController _controller = TextEditingController();
//   TextEditingController roomController = TextEditingController();
//   bool isVideoOff = true;
//   bool isAudioMuted = true;
//   String username = "";
//   bool isData = false;

//   @override
//   void initState() {
//     super.initState();
//     username = userdata["Name"];
//   }

//   joinMeeting() async {
//     try {
//       Map<FeatureFlagEnum.FeatureFlagEnum, bool> featureeFlags = {
//         FeatureFlagEnum.FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
//       };
//       if (Platform.isAndroid) {
//         featureeFlags[FeatureFlagEnum.FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//       } else if (Platform.isIOS) {
//         featureeFlags[FeatureFlagEnum.FeatureFlagEnum.PIP_ENABLED] = false;
//       }

//       var options = JitsiMeetingOptions()
//         ..room = roomController.text // Required, spaces will be trimmed
//         ..userDisplayName = _controller.text == "" ? username : _controller.text
//         ..audioMuted = isAudioMuted
//         ..videoMuted = isVideoOff
//         ..featureFlags.addAll(featureeFlags);

//       await JitsiMeet.joinMeeting(options);
//     } catch (err) {
//       print(err);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: 16,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 24,
//               ),
//               Text(
//                 "Room Code",
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               PinCodeTextField(
//                 controller: roomController,
//                 backgroundColor: Colors.white,
//                 appContext: context,
//                 autoDisposeControllers: false,
//                 length: 6,
//                 onChanged: (value) {},
//                 animationType: AnimationType.fade,
//                 pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
//                 animationDuration: Duration(microseconds: 300),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: _controller,
//                 style: TextStyle(fontSize: 20),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: "Username(this will be visible in the meeting)",
//                   labelStyle: TextStyle(fontSize: 15),
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               CheckboxListTile(
//                 value: isVideoOff,
//                 onChanged: (val) {
//                   setState(() {
//                     isVideoOff = val;
//                   });
//                 },
//                 title: Text(
//                   "Video Off",
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               CheckboxListTile(
//                 value: isAudioMuted,
//                 onChanged: (val) {
//                   setState(() {
//                     isAudioMuted = val;
//                   });
//                 },
//                 title: Text(
//                   "Audio Muted",
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "You can change these settings in your meeting when you join",
//                 style: TextStyle(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//               Divider(
//                 height: 48,
//                 thickness: 2.0,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               InkWell(
//                 onTap: joinMeeting,
//                 child: Container(
//                   width: double.maxFinite,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.greenAccent, Colors.green],
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Join Meeting",
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
