import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/Auth_services.dart';

class Descriptio extends StatefulWidget {
  final String clas;

  const Descriptio({Key key, @required this.clas}) : super(key: key);
  @override
  _DescriptioState createState() => _DescriptioState();
}

class _DescriptioState extends State<Descriptio> {
  Auth_services _auth_services = Auth_services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Assignment Description',
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white12,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _auth_services.getAllTeacherAssignments(widget.clas),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.docs
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(15),
                        height: 200,
                        child: Text(
                          e['Class'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
