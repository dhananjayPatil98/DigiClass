import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import 'package:school_management/Widgets/sprofilemodal.dart';
import 'package:school_management/services/getcolor.dart';
import 'package:school_management/services/getimage.dart';
import 'package:school_management/services/Auth_services.dart';

class sprofile extends StatefulWidget {
  @override
  sprofileState createState() => sprofileState();
}

class sprofileState extends State<sprofile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Auth_services _auth = Auth_services();
  File selectedImage;
  String flag1, flag2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: getcolor(),
        elevation: 0.0,
      ),
      body: Container(
        child: StreamBuilder(
            stream: _auth.getCurrentUserStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> userdata = snapshot.data.data();
                if (userdata["isTeacher"] == "false") {
                  flag1 = 'Rollno';
                  flag2 = userdata['Rollno'];
                } else {
                  flag1 = 'Teacher id';
                  flag2 = userdata['Teacher id'];
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (selectedImage != null)
                                      ? Image.file(
                                          selectedImage,
                                          fit: BoxFit.fill,
                                        )
                                      : userdata.containsKey("profile_pic")
                                          ? userdata['profile_pic'] == null ||
                                                  userdata['profile_pic'] == ""
                                              ? Image.asset(
                                                  "assets/home.png",
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  userdata['profile_pic'],
                                                  fit: BoxFit.fill,
                                                )
                                          : Image.asset(
                                              "assets/home.png",
                                              fit: BoxFit.fill,
                                            ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 70.0,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add_a_photo,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                File data = await imgFromGallery();
                                print("Selected Image : ${data.path}");
                                if (data != null) {
                                  setState(() {
                                    selectedImage = data;
                                  });
                                  await _auth.storeimg(selectedImage);
                                } else
                                  print('NULL');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text('Email',
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                    SizedBox(width: 20.0),
                    Text(userdata["Email"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              Text('Name',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                              Text(userdata["Name"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Class',
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18.0)),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(userdata["Class"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 8, 20, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Mobile No',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18.0)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(userdata["PhoneNo"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(flag1,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18.0)),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(flag2,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 18, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Birthdate',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18.0)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(userdata["Birthdate"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Gender",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18.0)),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(userdata["Gender"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Address",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              " " + userdata["Address"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: getcolor(),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      sprofilemodal());
                            },
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              return CircularProgressIndicator();
            }),
      ),
      // body: Container(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             Align(
      //               alignment: Alignment.center,
      //               child: CircleAvatar(
      //                 radius: 70,
      //                 backgroundColor: Colors.white,
      //                 child: ClipOval(
      //                   child: new SizedBox(
      //                     width: 180.0,
      //                     height: 180.0,
      //                     child: (selectedImage != null)
      //                         ? Image.file(
      //                             selectedImage,
      //                             fit: BoxFit.fill,
      //                           )
      //                         : userdata.containsKey("profile_pic")
      //                             ? userdata['profile_pic'] == null ||
      //                                     userdata['profile_pic'] == ""
      //                                 ? Image.asset(
      //                                     "assets/home.png",
      //                                     fit: BoxFit.fill,
      //                                   )
      //                                 : Image.network(
      //                                     userdata['profile_pic'],
      //                                     fit: BoxFit.fill,
      //                                   )
      //                             : Image.asset(
      //                                 "assets/home.png",
      //                                 fit: BoxFit.fill,
      //                               ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(
      //                 top: 70.0,
      //               ),
      //               child: IconButton(
      //                 icon: Icon(
      //                   Icons.add_a_photo,
      //                   size: 30.0,
      //                 ),
      //                 onPressed: () async {
      //                   File data = await imgFromGallery();
      //                   print("Selected Image : ${data.path}");
      //                   if (data != null) {
      //                     setState(() {
      //                       selectedImage = data;
      //                     });
      //                     await _auth.storeimg(selectedImage);
      //                   } else
      //                     print('NULL');
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: 50.0,
      //       ),
      //       Text('Email',
      //           style: TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
      //       SizedBox(width: 20.0),
      //       Text(userdata["Email"],
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 20.0,
      //               fontWeight: FontWeight.bold)),
      //       SizedBox(
      //         height: 30.0,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               children: <Widget>[
      //                 Text('Name',
      //                     style: TextStyle(
      //                         color: Colors.blueGrey, fontSize: 18.0)),
      //                 Text(userdata["Name"],
      //                     style: TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 20.0,
      //                         fontWeight: FontWeight.bold)),
      //               ],
      //             ),
      //             Column(
      //               children: [
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Container(
      //                     child: Column(
      //                       children: <Widget>[
      //                         Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text('Class',
      //                               style: TextStyle(
      //                                   color: Colors.blueGrey,
      //                                   fontSize: 18.0)),
      //                         ),
      //                         Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text(userdata["Class"],
      //                               style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 20.0,
      //                                   fontWeight: FontWeight.bold)),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(30, 8, 20, 30),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               children: <Widget>[
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Text('Mobile No',
      //                       style: TextStyle(
      //                           color: Colors.blueGrey, fontSize: 18.0)),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Text(userdata["PhoneNo"],
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 20.0,
      //                           fontWeight: FontWeight.bold)),
      //                 ),
      //               ],
      //             ),
      //             Column(
      //               children: [
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Container(
      //                     child: Column(
      //                       children: <Widget>[
      //                         Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text('Roll No',
      //                               style: TextStyle(
      //                                   color: Colors.blueGrey,
      //                                   fontSize: 18.0)),
      //                         ),
      //                         Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text(userdata["Rollno"],
      //                               style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 20.0,
      //                                   fontWeight: FontWeight.bold)),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(35, 8, 18, 30),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               children: <Widget>[
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Text('Birthdate',
      //                       style: TextStyle(
      //                           color: Colors.blueGrey, fontSize: 18.0)),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Text(userdata["Birthdate"],
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 20.0,
      //                           fontWeight: FontWeight.bold)),
      //                 ),
      //               ],
      //             ),
      //             Column(
      //               children: [
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Container(
      //                     child: Column(
      //                       children: <Widget>[
      //                         Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text("Gender",
      //                               style: TextStyle(
      //                                   color: Colors.blueGrey,
      //                                   fontSize: 18.0)),
      //                         ),
      //                         Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text(userdata["Gender"],
      //                               style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 20.0,
      //                                   fontWeight: FontWeight.bold)),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           children: [
      //             Align(
      //               alignment: Alignment.centerLeft,
      //               child: Text("Address",
      //                   style:
      //                       TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
      //             ),
      //             SizedBox(
      //               width: 300,
      //               child: Text(
      //                 " " + userdata["Address"],
      //                 overflow: TextOverflow.ellipsis,
      //                 maxLines: 3,
      //                 softWrap: false,
      //                 style: TextStyle(
      //                     color: Colors.black,
      //                     fontSize: 20.0,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(top: 40),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: <Widget>[
      //             TextButton(
      //               style: TextButton.styleFrom(
      //                 backgroundColor: getcolor(),
      //               ),
      //               onPressed: () {
      //                 showModalBottomSheet(
      //                     isScrollControlled: true,
      //                     context: context,
      //                     builder: (BuildContext context) => sprofilemodal());
      //               },
      //               child: Text(
      //                 'Edit Profile',
      //                 style: TextStyle(color: Colors.white, fontSize: 20.0),
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),

      // ),
    );
  }

  getimgpath() {
    File img;
    img = selectedImage;
    return img;
  }
}
