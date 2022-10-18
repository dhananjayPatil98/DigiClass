import "package:flutter/material.dart";
import 'package:school_management/services/getcolor.dart';
import 'package:uuid/uuid.dart';

class CreateMeeetingScreen extends StatefulWidget {
  @override
  _CreateMeeetingScreenState createState() => _CreateMeeetingScreenState();
}

class _CreateMeeetingScreenState extends State<CreateMeeetingScreen> {
  String code = "";
  var isVis = false;

  generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
      isVis = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getcolor(),
        title: Text('Create Meeting'),
        titleSpacing: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 170, height: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white60, elevation: 2),
                    onPressed: () {},
                    child: Text(
                      'Join Meeting',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 170, height: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white60, elevation: 2),
                    onPressed: () {},
                    child: Text(
                      'Join Meeting',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Create a code to create a meeting!",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            isVis == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Code: ",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        code,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: generateMeetingCode,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent, Colors.green],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Create Code",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
