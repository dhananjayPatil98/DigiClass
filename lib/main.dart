import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management/Screens/SpleashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Auth_services _auth_services = Auth_services();
    // _auth_services.signoutuser();
    // print("Signing... Out");
  }

  // bro Register kar

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digi class',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: SpleashScreen(),
      //home: ExampleApp(),
    );
  }
}
