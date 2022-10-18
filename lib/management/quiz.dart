import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  int correct = 0, incorrect = 0, total = 0;
  List<String> options = [];
  QuerySnapshot quizDatas;
  List<Map<String, dynamic>> quizMapData = [];
  bool answered = false;
  List<String> inCorrectOption = [];
  List<String> selectedOptions = [];
  List<String> correctOption = [];
  List<List<String>> suffledOptions = [];

  setQuizDatas(QuerySnapshot docs) {
    quizDatas = docs;
    for (var item in docs.docs) {
      if (!quizMapData.contains(item.data())) quizMapData.add(item.data());
      selectedOptions.add("-99");

      List<String> options = [
        item.data()['option1'],
        item.data()['option2'],
        item.data()['option3'],
        item.data()['option4']
      ];
      options.shuffle();
      suffledOptions.add(options);
    }
    update();
  }

  reset() {
    correct = 0;
    incorrect = 0;
    total = 0;
    options = [];

    quizMapData = [];
    inCorrectOption = [];
    selectedOptions = [];
    correctOption = [];
    suffledOptions = [];
    update();
  }

  //a - 1 option = [c, b, ]

  // init(QueryDocumentSnapshot data, int total, int notAttempted) {
  //   total = total;
  //   notAttempted = notAttempted;
  //   incorrect = 0;
  //   correct = 0;
  //   options = [
  //     data['option1'],
  //     data['option2'],
  //     data['option3'],
  //     data['option4'],
  //   ];
  //   // options.shuffle();
  //   option1 = options[0];
  //   option2 = options[1];
  //   option3 = options[2];
  //   option4 = options[3];
  //   correctOpt = data['option1'];
  //   answered = false;
  //   update();
  // }

  int getnotAttempted() {
    int data =
        selectedOptions.where((element) => element == "-99").toList().length;
    debugPrint("LENGTH L: ${data}");
    return selectedOptions.where((element) => element == "-99").toList().length;
  }

  onClicked(String value, int index) {
    try {
      if (selectedOptions[index] == "-99") {
        selectedOptions[index] = value;
        if (correctOption[index] == value) correct += 1;
        if (correctOption[index] != value)
          incorrect += 1; //else if diya isliye kya? abhi try karke dekh xd
      }//ek no sunnnnnnn aur ek xd ye bhi chota hai
    } catch (e) {
      selectedOptions.add(value);
    }
    debugPrint("Correct : $correct");
    debugPrint("incorrect : $incorrect");
    debugPrint("selectedOptions : $selectedOptions");
    debugPrint("correct : $correct");
    // option = ["b", "c"];
    // option[1] "c"

    // if (!answered) {
    //   //correct
    //   if (option1 == correctOpt) {
    //     optionSelected = option1;
    //     answered = true;
    //     notAttempted = notAttempted - 1;
    //     correct = correct + 1;
    //   } else {
    //     optionSelected = option1;
    //     answered = true;
    //     incorrect = incorrect + 1;
    //     notAttempted = notAttempted - 1;
    //   }
    // }
    // print("correct : $correct");
    update();
  }

  // onBClicked() {
  //   if (!answered) {
  //     //correct
  //     if (option2 == correctOpt) {
  //       optionSelected = option2;
  //       answered = true;
  //       notAttempted = notAttempted - 1;
  //       correct = correct + 1;
  //     } else {
  //       optionSelected = option2;
  //       answered = true;
  //       incorrect = incorrect + 1;
  //       notAttempted = notAttempted - 1;
  //     }
  //   }
  //   print("correct : $correct");
  //   update();
  // }

  // onCClicked() {
  //   if (!answered) {
  //     //correct
  //     if (option3 == correctOpt) {
  //       optionSelected = option3;
  //       answered = true;
  //       notAttempted = notAttempted - 1;
  //       correct = correct + 1;
  //     } else {
  //       optionSelected = option3;
  //       answered = true;
  //       incorrect = incorrect + 1;
  //       notAttempted = notAttempted - 1;
  //     }
  //   }
  //   print("correct : $correct");
  //   update();
  // }

  // onDClicked() {
  //   if (!answered) {
  //     //correct
  //     if (option4 == correctOpt) {
  //       optionSelected = option4;
  //       answered = true;
  //       notAttempted = notAttempted - 1;
  //       correct = correct + 1;
  //       print(correct);
  //     } else {
  //       optionSelected = option4;
  //       answered = true;
  //       incorrect = incorrect + 1;
  //       notAttempted = notAttempted - 1;
  //     }
  //   }
  //   print("correct : $correct");
  //   update();
  // }
}
