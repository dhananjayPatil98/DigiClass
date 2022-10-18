import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/Screens/Exam/optionTile.dart';
import 'package:school_management/management/quiz.dart';

class QuizWidget extends StatefulWidget {
  // final QueryDocumentSnapshot data;
  // final int total, notAttempted;
  // QuizWidget(
  //     {@required this.data, @required this.total, @required this.notAttempted});
  @override
  QuizWidgetState createState() => QuizWidgetState();
}

class QuizWidgetState extends State<QuizWidget> {
  // List<String> options = [];
  // int correct = 0, incorrect = 0, total = 0, notAttempted = 0;
  // String optionSelected = "", option1, option2, option3, option4, correctOpt;
  // bool answered;
  QuizController quizController = Get.put(QuizController());
  @override
  initState() {
    super.initState();
    // quizController.init(widget.data, widget.total, widget.notAttempted);
    // total = widget.total;
    // notAttempted = widget.notAttempted;
    // incorrect = 0;
    // correct = 0;
    // options = [
    //   widget.data['option1'],
    //   widget.data['option2'],
    //   widget.data['option3'],
    //   widget.data['option4'],
    // ];
    // options.shuffle();
    // option1 = options[0];
    // option2 = options[1];
    // option3 = options[2];
    // option4 = options[3];
    // correctOpt = widget.data['option1'];
    // answered = false;
  }

  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(builder: (controller) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Total Questions: ' + controller.total.toString()),
                  Text('Not attempted: ' +
                      controller.getnotAttempted().toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: quizController.quizMapData.map((e) {
                  debugPrint("Quiz Index");
                  // quizController.suffledOptions.add(op)
                  quizController.correctOption.add(e['option1']);
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '(Q)   ' + e['Question'],
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      OptionTile(
                        correctAns: e['option1'],
                        options: quizController.suffledOptions[
                            quizController.quizMapData.indexOf(e)],
                        quizIndex: quizController.quizMapData.indexOf(e),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                    ],
                  );
                }).toList(),
                // children: [
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Text('Total Questions: ' + controller.total.toString()),
                //       Text('Not attempted: ' + controller.notAttempted.toString()),
                //     ],
                //   ),
                //   SizedBox(
                //     height: 30,
                //   ),
                //   //Kidhar??
                //   Text(
                //     '(Q)   ' + widget.data['Question'],
                //     style: TextStyle(fontSize: 18, color: Colors.black87),
                //   ),
                //   SizedBox(
                //     height: 12,
                //   ),
                //   GestureDetector(
                //     onTap: controller.onAClicked,
                //     child: OptionTile(
                //       correctAns: controller.correctOpt,
                //       description: controller.option1,
                //       option: "A",
                //       optionSelected: controller.optionSelected,
                //     ),
                //   ),
                //   SizedBox(
                //     height: 4,
                //   ),
                //   GestureDetector(
                //     onTap: controller.onBClicked,
                //     child: OptionTile(
                //       correctAns: controller.correctOpt,
                //       description: controller.option2,
                //       option: "B",
                //       optionSelected: controller.optionSelected,
                //     ),
                //   ),
                //   SizedBox(
                //     height: 4,
                //   ),
                //   GestureDetector(
                //     onTap: controller.onCClicked,
                //     child: OptionTile(
                //       correctAns: controller.correctOpt,
                //       description: controller.option3,
                //       option: "C",
                //       optionSelected: controller.optionSelected,
                //     ),
                //   ),
                //   SizedBox(
                //     height: 4,
                //   ),
                //   GestureDetector(
                //     onTap: controller.onDClicked,
                //     child: OptionTile(
                //       correctAns: controller.correctOpt,
                //       description: controller.option4,
                //       option: "D",
                //       optionSelected: controller.optionSelected,
                //     ),
                //   ),
                //   SizedBox(
                //     height: 28,
                //   ),
                // ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
