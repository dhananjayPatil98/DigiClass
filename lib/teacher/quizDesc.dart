import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';

class TQuizDesc extends StatefulWidget {
  final String desc;

  const TQuizDesc({Key key, @required this.desc}) : super(key: key);
  @override
  _TQuizDescState createState() => _TQuizDescState();
}

class _TQuizDescState extends State<TQuizDesc> {
  Auth_services _auth_services = Auth_services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Quiz Description',
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white12,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: [
                Text(
                  widget.desc,
                  style: TextStyle(fontSize: 18, letterSpacing: 1),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
