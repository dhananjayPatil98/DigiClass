import "package:flutter/material.dart";
import 'package:school_management/teacher/createmeet.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  tabBuilder(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child:
              Text(name, style: TextStyle(fontSize: 15, color: Colors.black)),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Lectures",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            tabBuilder("Join Meeting"),
            tabBuilder("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CreateMeeetingScreen(),
        ],
      ),
    );
  }
}
