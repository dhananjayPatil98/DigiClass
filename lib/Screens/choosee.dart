import 'package:flutter/material.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/teacher/tlogin.dart';

class choosee extends StatefulWidget {
  @override
  _chooseeState createState() => _chooseeState();
}

class _chooseeState extends State<choosee> with SingleTickerProviderStateMixin {
  TextEditingController _code = TextEditingController();
  dynamic _error = " ";
  _displaydail(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: _code,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.numberWithOptions(),
            decoration:
                InputDecoration(hintText: "Enter Code To Access Teacher Login"),
          ),
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                if (_code.text == '1234') {
                  _error = ' ';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => tlogin()));
                } else if (_code.text.isEmpty) {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('You must Enter a code'),
                      backgroundColor: Colors.red[400],
                    ),
                  );
                } else {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Invalid Code'),
                      backgroundColor: Colors.red[400],
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();

    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Transform(
                  transform: Matrix4.translationValues(
                      animation.value * width, 0.0, 0.0),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          child: Center(
                            child: Text(
                              'Join as Student',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Center(
                              child: ClipOval(
                                child: Image(
                                  height: 150,
                                  image: AssetImage('assets/std.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 250, 30.0, 5),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: Container(
                              child: Column(
                                children: [
                                  Bouncing(
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MyHomePage()),
                                        );
                                      },
                                      elevation: 0.0,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      color: Colors.blue,
                                      child: Text(
                                        "Join",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 350),
                          child: Container(
                            child: Center(
                              child: Text(
                                'Join as Teacher',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 400),
                            child: Center(
                              child: ClipOval(
                                child: Image(
                                  height: 150,
                                  image: AssetImage('assets/teach.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 600, 30.0, 5),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: Container(
                              child: Column(
                                children: [
                                  Bouncing(
                                    child: MaterialButton(
                                      onPressed: () => _displaydail(context),
                                      elevation: 0.0,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      color: Colors.blue,
                                      child: Text(
                                        "Join",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
