import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/management/quiz.dart';

class OptionTile extends StatefulWidget {
  final String correctAns, optionSelected;
  int quizIndex;
  List<String> options;
  final bool answered;
  OptionTile(
      {this.correctAns,
      this.options,
      this.optionSelected,
      this.answered,
      @required this.quizIndex});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  QuizController quizController = Get.put(QuizController());
  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.options
            .map((e) => GestureDetector(
                  onTap: () {
                    quizController.onClicked(e, widget.quizIndex);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: e ==
                                        quizController
                                            .selectedOptions[widget.quizIndex]
                                    ? quizController.selectedOptions[
                                                widget.quizIndex] ==
                                            quizController
                                                .correctOption[widget.quizIndex]
                                        ? Colors.green.withOpacity(0.7)
                                        : Colors.red.withOpacity(0.7)
                                    : Colors.grey,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  getAlphabet(widget.options.indexOf(e)),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: e ==
                                            quizController.selectedOptions[
                                                widget.quizIndex]
                                        ? quizController.selectedOptions[
                                                    widget.quizIndex] ==
                                                quizController.correctOption[
                                                    widget.quizIndex]
                                            ? Colors.green.withOpacity(0.7)
                                            : Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          e,
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}

String getAlphabet(int index) {
  if (index == 0) return "A";
  if (index == 1) return "B";
  if (index == 2) return "C";
  if (index == 3) return "D";
  return "A";
}
