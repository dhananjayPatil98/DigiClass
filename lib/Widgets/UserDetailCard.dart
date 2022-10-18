import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_management/Widgets/sprofile.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:school_management/services/getcolor.dart';

class UserDetailCard extends StatefulWidget {
  @override
  _UserDetailCardState createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  sprofileState ob = sprofileState();
  dynamic tid = ' ', utid = ' ';
  String name;
  File selectedImage;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyData();
  }

  getMyData() async {
    setState(() {
      selectedImage = ob.getimgpath();
    });
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
    await getCurrentData();
    await comp();
    name = userdata["Name"].toString();
    name = name.split(" ")[0];
    print(name);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> comp() async {
    if (userdata["isTeacher"] == 'false') {
      tid = 'RollNo';
      utid = await userdata["Rollno"];
    } else if (userdata["isTeacher"] == 'true') {
      tid = 'Teacher id';
      utid = await userdata["Teacher id"];
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return isLoading
            ? CircularProgressIndicator()
            : userdata == null
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 3),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getcolor(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: height * 0.17,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(
                                    muchDelayedAnimation.value * width, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: new SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            child: (selectedImage != null)
                                                ? Image.file(
                                                    selectedImage,
                                                    fit: BoxFit.fill,
                                                  )
                                                : userdata.containsKey(
                                                        "profile_pic")
                                                    ? userdata['profile_pic'] ==
                                                                null ||
                                                            userdata[
                                                                    'profile_pic'] ==
                                                                ""
                                                        ? Image.asset(
                                                            "assets/home.png",
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            userdata[
                                                                'profile_pic'],
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
                                  ],
                                ),
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                    delayedAnimation.value * width, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      tid,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                                    Text(
                                      utid,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                    delayedAnimation.value * width, 0, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Department',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      userdata['Class'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
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
