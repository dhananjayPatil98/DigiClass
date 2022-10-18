import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:school_management/services/currentuser.dart';
import 'package:intl/intl.dart';

class Auth_services {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage st = FirebaseStorage.instance;
  String get currentUserUid => auth.currentUser.uid;

  //login and register student
  Future register_user(String email, String password, String name,
      String rollno, String dept, String phn, String steach) async {
    try {
      print(rollno);
      print(email);
      UserCredential usercred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      db
          .collection('DigiClass')
          .doc('Registration')
          .collection('student-teacher')
          .doc(usercred.user.uid)
          .set({
        "uid": usercred.user.uid,
        "Name": name,
        "Email": email,
        "Rollno": rollno,
        "Class": dept,
        "PhoneNo": phn,
        "isTeacher": steach,
        "Birthdate": 'NA',
        "Gender": 'NA',
        "Address": 'NA',
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  Future login_user(String email, String password) async {
    try {
      UserCredential usercred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(usercred);
    } catch (e) {
      throw e.message;
      // print(e.message);
    }
  }

  //get current user
  Future<Map<String, dynamic>> getCurrentUser() async {
    String uid = auth.currentUser.uid;
    DocumentSnapshot doc = await db
        .collection('DigiClass')
        .doc('Registration')
        .collection('student-teacher')
        .doc(uid)
        .get();
    return doc.data();
  }

  //assignments
  Future<Map<String, dynamic>> getAssignmentUsers() async {
    DocumentSnapshot doc = await db
        .collection('DigiClass')
        .doc('Assignments')
        .collection('Student')
        .doc()
        .get();
    return doc.data();
  }

  //add assignments teacher
  Future<void> addassignment(
      String tid,
      String sub,
      String title,
      String subclass,
      String date,
      String name,
      String postedDate,
      String desp) async {
    print("Adding Assignments in DB");
    String id = db
        .collection('DigiClass')
        .doc('Assignments')
        .collection('teacher')
        .doc()
        .id;
    print("$id");
    db
        .collection('DigiClass')
        .doc('Assignments')
        .collection('teacher')
        .doc(id)
        .set({
      "id": id,
      "UserId": tid,
      "Assignmentstitle": title,
      "Subject": sub,
      "Class": subclass,
      "Duedate": date,
      "Name": name,
      "PostDate": postedDate,
      "Description": desp,
    });
  }

  Future<void> addAssignmentToDb(
      String uid,
      String name,
      String rollno,
      String sclass,
      List<File> filesList,
      String assignmentId,
      String date) async {
    String id = db
        .collection('DigiClass')
        .doc('Assignments')
        .collection("Student")
        .doc()
        .id;
    String fileName = filesList[0].path.split('/').last;
    final img = await st
        .ref()
        .child('Assignments/Student/$id/$fileName')
        .putFile(filesList[0]);
    String url = "";
    if (img != null) {
      try {
        url = await img.ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      print("No file found");
    }

    db
        .collection('DigiClass')
        .doc('Assignments')
        .collection("Student")
        .doc(id)
        .set({
      "uid": uid,
      "Name": name,
      "Url": url,
      "id": id,
      "docName": fileName,
      "Class": sclass,
      "Rollno": rollno,
      "assignmentId": assignmentId,
      "submitedDate": date,
    });
  }

//Teacher assignment
  Stream<QuerySnapshot> getAllassignments() {
    return db
        .collection('DigiClass')
        .doc('Assignments')
        .collection("teacher")
        .snapshots();
  }

  Stream<QuerySnapshot> getAllTeacherAssignments(String assignmentId) {
    return db
        .collection('DigiClass')
        .doc('Assignments')
        .collection('teacher')
        .where("id", isEqualTo: assignmentId)
        .snapshots();
  }

  Future deleteAssignment(String assignmentId, var data) async {
    QuerySnapshot docs = await db
        .collection("DigiClass")
        .doc("Assignments")
        .collection("Student")
        .where("assignmentId", isEqualTo: assignmentId)
        .get();
    for (var item in docs.docs) {
      String id = item.data()['id'];
      db
          .collection("DigiClass")
          .doc("Assignments")
          .collection("Student")
          .doc(id)
          .delete();
      debugPrint("Assignments/Student/$id/${data['docName']}");
      try {
        await st
            .ref()
            .child("Assignments/Student/$id/${data['docName']}")
            .delete()
            .then((_) =>
                print('Successfully deleted ${data['docName']} storage item'));
      } catch (e) {
        print(e);
      }
    }
    db
        .collection("DigiClass")
        .doc("Assignments")
        .collection("teacher")
        .doc(assignmentId)
        .delete();
  }

  //assignment snapshot student
  Stream<QuerySnapshot> getAssignmentsByUser(String uid, String assignmentId) {
    return db
        .collection('DigiClass')
        .doc("Assignments")
        .collection("Student")
        .where("uid", isEqualTo: uid)
        .where("assignmentId", isEqualTo: assignmentId)
        .snapshots();
  }

  Stream<QuerySnapshot> getAlluserAssignments(String assignmentId) {
    return db
        .collection('DigiClass')
        .doc('Assignments')
        .collection('Student')
        .where("assignmentId", isEqualTo: assignmentId)
        .snapshots();
  }

  //delete assignment student
  Future sdeleteAssignment(var assignmentData) async {
    await sdeleteAssignmentfile(assignmentData);
    await db
        .collection("DigiClass")
        .doc("Assignments")
        .collection("Student")
        .doc(assignmentData['id'])
        .delete()
        .then((value) => print("Deleted Successfully"))
        .catchError((onError) => print(onError));
  }

  Future sdeleteAssignmentfile(var assignmentData) async {
    print(
        "Assignments/Student${assignmentData['id']}/${assignmentData['docName']}");
    try {
      st
          .ref()
          .child(
              "Assignments/Student/${assignmentData['id']}/${assignmentData['docName']}")
          .delete()
          .then((_) => print(
              'Successfully deleted ${assignmentData['docName']} storage item'));
    } catch (e) {
      print(e);
    }
  }

  //current user stream
  Stream<DocumentSnapshot> getCurrentUserStream() {
    String uid = auth.currentUser.uid;
    return db
        .collection('DigiClass')
        .doc('Registration')
        .collection('student-teacher')
        .doc(uid)
        .snapshots();
  }

  //teacher register
  Future tregister_user(String email, String password, String name, String tid,
      String dept, String mob, String tteach, String teacher) async {
    try {
      print(email);
      UserCredential tcred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      db
          .collection('DigiClass')
          .doc('Registration')
          .collection('student-teacher')
          .doc(tcred.user.uid)
          .set({
        "uid": tcred.user.uid,
        "Name": name,
        "Email": email,
        "Teacher id": tid,
        "Class": dept,
        "PhoneNo": mob,
        "isTeacher": tteach,
        "Birthdate": 'NA',
        "Gender": 'NA',
        "Address": 'NA',
        "ClassTeacher": teacher,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  //store image
  Future storeimg(File image) async {
    String uid = auth.currentUser.uid;
    String fileName = image.path.split('/').last;
    final img = await st.ref().child('Images/Profile/$fileName').putFile(image);
    if (img != null) {
      try {
        final String url = await img.ref.getDownloadURL();
        db
            .collection('DigiClass')
            .doc('Registration')
            .collection('student-teacher')
            .doc(uid)
            .update({"profile_pic": url});
      } catch (e) {
        print(e);
      }
    } else {
      print("No image found");
    }
  }

  //update user
  Future updateuser(String _name, String _mob, String _roll, String _birthdate,
      String _gender, String _address) async {
    String uid = auth.currentUser.uid;
    try {
      db
          .collection('DigiClass')
          .doc('Registration')
          .collection('student-teacher')
          .doc(uid)
          .update({
        "Name": _name,
        "Rollno": _roll,
        "PhoneNo": _mob,
        "Birthdate": _birthdate,
        "Gender": _gender,
        "Address": _address,
      });
    } catch (e) {
      return e;
    }
  }

  //signout user
  Future signoutuser() async {
    await auth.signOut();
  }

  //reset password
  Future resetpass(String _email) async {
    try {
      auth.sendPasswordResetEmail(email: _email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      }
    } catch (e) {
      return e;
    }
  }

  //add leave student
  Future addleave(String type, String from, String to, String reason) async {
    String leaveid =
        db.collection('DigiClass').doc('Leave').collection('Student').doc().id;
    String uid = auth.currentUser.uid;
    db
        .collection('DigiClass')
        .doc('Leave')
        .collection('Student')
        .doc(leaveid)
        .set({
      "Name": userdata['Name'],
      "Rollno": userdata['Rollno'],
      "Type": type,
      "From": from,
      "To": to,
      "Reason": reason,
      "LeaveID": leaveid,
      "UserID": uid,
    });
  }

  Stream<QuerySnapshot> getStudentLeave() {
    return db
        .collection('DigiClass')
        .doc('Leave')
        .collection('Student')
        .snapshots();
  }

  //add notes teacher
  Future<void> addNotesToDb(String userId, String notesTitle, String subclass,
      List<File> filesList, String name, String date) async {
    String id =
        db.collection('DigiClass').doc('Notes').collection("teacher").doc().id;
    String fileName = filesList[0].path.split('/').last;
    final img = await st
        .ref()
        .child('Notes/Teacher/$id/$fileName')
        .putFile(filesList[0]);
    String url = "";
    if (img != null) {
      try {
        url = await img.ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      print("No file found");
    }

    db.collection('DigiClass').doc('Notes').collection("teacher").doc(id).set({
      "userId": userId,
      "notesTitle": notesTitle,
      "notesDocs": url,
      "id": id,
      "docName": fileName,
      "subClass": subclass,
      "postedBy": name,
      "date": date,
    });
  }

  Stream<QuerySnapshot> getAllNotes() {
    return db
        .collection('DigiClass')
        .doc('Notes')
        .collection("teacher")
        .snapshots();
  }

  static var httpClient = new HttpClient();

  //delete notes
  Future deleteNotes(var notesData) async {
    await deleteNotesFile(notesData);
    await db
        .collection("DigiClass")
        .doc("Notes")
        .collection("teacher")
        .doc(notesData['id'])
        .delete()
        .then((value) => print("Deleted Successfully"))
        .catchError((onError) => print(onError));
  }

  Future deleteNotesFile(var notesData) async {
    print("Notes/Teacher/${notesData['id']}/${notesData['docName']}");
    try {
      await st
          .ref()
          .child("Notes/Teacher/${notesData['id']}/${notesData['docName']}")
          .delete()
          .then((_) => print(
              'Successfully deleted ${notesData['docName']} storage item'));
    } catch (e) {
      print(e);
    }
  }

  //file download
  Future<File> downloadFile(String url, String fileName) async {
    print(url);
    print(fileName);
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await DownloadsPathProvider.downloadsDirectory).path;
      print(dir);
      File file = new File('$dir/$fileName');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      return e;
    }
  }

  //teacher quiz create
  Future<String> tCreateQuiz(
      String title,
      String desc,
      String sub,
      String clss,
      String date,
      String curDate,
      String postedBy,
      String teacherID,
      bool ismcq) async {
    try {
      String docId =
          db.collection('DigiClass').doc('Quiz').collection('Teacher').doc().id;
      db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(docId)
          .set(
        {
          "Quiz_Title": title,
          "Quiz_Des": desc,
          "Subject": sub,
          "Class": clss,
          "Due": date,
          "Posted_Date": curDate,
          "Posted_By": postedBy,
          "Tid": teacherID,
          "Quiz_ID": docId,
          "Mcq": ismcq,
        },
      );
      return docId;
    } catch (e) {
      print(e);
      return e;
    }
  }

  //add question teacher
  Future<void> taddQuizMcqQues(String que, String option1, String option2,
      String option3, String option4, String quizId) async {
    try {
      String queId = db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(quizId)
          .collection('QNA')
          .doc()
          .id;
      await db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(quizId)
          .collection('QNA')
          .doc(queId)
          .set(
        {
          "Question": que,
          "option1": option1,
          "option2": option2,
          "option3": option3,
          "option4": option4,
          "QuesID": queId,
        },
      );
    } catch (e) {
      return e;
    }
  }

  //Teacher quiz theory questions
  Future addQuizTheoryQuestions(String quizId, String que) async {
    try {
      String queId = db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(quizId)
          .collection('Theory')
          .doc()
          .id;
      await db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(quizId)
          .collection('QNA')
          .doc(queId)
          .set(
        {
          "Question": que,
          "QuesID": queId,
        },
      );
    } catch (e) {}
  }

  //Teacher quiz snapshot
  Stream<QuerySnapshot> getAllQuiz() {
    return db
        .collection('DigiClass')
        .doc('Quiz')
        .collection('Teacher')
        .snapshots();
  }

  //Delete Quiz
  Future deleteQuiz(var quizdata) async {
    await db
        .collection('DigiClass')
        .doc('Quiz')
        .collection('Teacher')
        .doc(quizdata['Quiz_ID'])
        .delete()
        .then((value) => print("Deleted Successfully"))
        .catchError((onError) => print(onError));
  }

  //get quiz qeuestion
  Stream<QuerySnapshot> getQuizQuestion(String quizId) {
    var snapshot = db
        .collection('DigiClass')
        .doc('Quiz')
        .collection('Teacher')
        .doc(quizId)
        .collection('QNA')
        .snapshots();
    return snapshot;
  }

  //save user quiz report
  Future quizMcqStudent(String quizId, int correct, int notattempted,
      int incorrect, String date, String subject, bool type) async {
    String name, roll;
    String uid = currentUserUid;
    name = userdata['Name'];
    roll = userdata['Rollno'];

    try {
      db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Student')
          .doc(currentUserUid)
          .collection('User')
          .doc(quizId)
          .set({
        "QuizId": quizId,
        "Correct": correct,
        "NotAttempted": notattempted,
        "Incorrect": incorrect,
        "StudentId": uid,
        "StudentName": name,
        "StudentRollNo": roll,
        "SubmitedOn": date,
        "Subject": subject,
        "Mcq": type,
      });
    } catch (e) {
      print(e);
    }
    try {
      db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(quizId)
          .collection('Student')
          .doc(uid)
          .set(
        {
          "QuizId": quizId,
          "Correct": correct,
          "NotAttempted": notattempted,
          "Incorrect": incorrect,
          "StudentId": uid,
          "StudentName": name,
          "StudentRollNo": roll,
          "SubmitedOn": date,
          "Subject": subject,
          "Mcq": type,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot> finishedquiz(String quizId) async {
    var fq = await db
        .collection('DigiClass')
        .doc('Quiz')
        .collection('Student')
        .doc(currentUserUid)
        .collection('User')
        .where("QuizId", isEqualTo: quizId)
        .get();

    print("1" + fq.toString());
    return fq;
  }

  Future quizTheoryStudent(
      String quizId, List<File> filesList, String date, bool type) async {
    String name, roll;
    String uid = currentUserUid;
    name = userdata['Name'];
    roll = userdata['Rollno'];
    List<String> filesUploadedList = [];
    List<String> filesName = [];
    try {
      for (int i = 0; i < filesList.length; i++) {
        String fileName = filesList[i].path.split('/').last;
        final img = await st
            .ref()
            .child('Quiz/Student/$uid/$quizId/$fileName')
            .putFile(filesList[0]);
        if (img != null) {
          try {
            String url = await img.ref.getDownloadURL();
            filesUploadedList.add(url);
            filesName.add(fileName);
          } catch (e) {
            print(e);
          }
        } else {
          print("No file found");
        }
      }
      db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Teacher')
          .doc(quizId)
          .collection('Student')
          .doc(uid)
          .set(
        {
          "QuizId": quizId,
          "StudentId": uid,
          "StudentName": name,
          "StudentRollNo": roll,
          "SubmitedOn": date,
          "Url": filesUploadedList,
          "FileName": filesName,
          "Mcq": type,
        },
      );
      db
          .collection('DigiClass')
          .doc('Quiz')
          .collection('Student')
          .doc(uid)
          .collection('User')
          .doc(quizId)
          .set(
        {
          "QuizId": quizId,
          "StudentId": uid,
          "StudentName": name,
          "StudentRollNo": roll,
          "SubmitedOn": date,
          "Url": filesUploadedList,
          "FileName": filesName,
          "Mcq": type,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> getStudentExamReport1(String quizId) {
    return db
        .collection('DigiClass')
        .doc('Quiz')
        .collection('Teacher')
        .doc(quizId)
        .collection('Student')
        .snapshots();
  }

  Stream<QuerySnapshot> getStudentExamReport2() {
    return db
        .collection('DigiClass')
        .doc('Quiz')
        .collection('Student')
        .doc(currentUserUid)
        .collection('User')
        .snapshots();
  }

  //Teacher report
  Future addTeacherReport(String uid, String sub, String clss,
      List<File> report, String name, String date) async {
    String id = db
        .collection('DigiClass')
        .doc('Quiz')
        .collection("TeacherReport")
        .doc()
        .id;
    String fileName = report[0].path.split('/').last;
    final img = await st
        .ref()
        .child('Quiz/TeacherReport/$id/$fileName')
        .putFile(report[0]);
    String url = "";
    if (img != null) {
      try {
        url = await img.ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      print("No file found");
    }

    db
        .collection('DigiClass')
        .doc('Quiz')
        .collection("TeacherReport")
        .doc(id)
        .set({
      "userId": uid,
      "Subject": sub,
      "notesDocs": url,
      "id": id,
      "docName": fileName,
      "Class": clss,
      "postedBy": name,
      "date": date,
    });
  }

  Stream<QuerySnapshot> getAllTeacherReport() {
    return db
        .collection('DigiClass')
        .doc('Quiz')
        .collection("TeacherReport")
        .snapshots();
  }

  Future deleteTeacherReport(var reportdata) async {
    await deleteTeacherReportFile(reportdata);
    await db
        .collection("DigiClass")
        .doc("Quiz")
        .collection("TeacherReport")
        .doc(reportdata['id'])
        .delete()
        .then((value) => print("Deleted Successfully"))
        .catchError((onError) => print(onError));
  }

  Future deleteTeacherReportFile(var reportData) async {
    print("Quiz/TeacherReport/${reportData['id']}/${reportData['docName']}");
    try {
      await st
          .ref()
          .child(
              "Quiz/TeacherReport/${reportData['id']}/${reportData['docName']}")
          .delete()
          .then((_) => print(
              'Successfully deleted ${reportData['docName']} storage item'));
    } catch (e) {
      print(e);
    }
  }

  //create meet data
  Future createMeetingData(String id, String pass, String sub, String title,
      String clss, String duedate, String date, String name, String uid) async {
    var meetDocId = db
        .collection('DigiClass')
        .doc('Meeting')
        .collection('Teacher')
        .doc()
        .id;
    db
        .collection('DigiClass')
        .doc('Meeting')
        .collection('Teacher')
        .doc(meetDocId)
        .set({
      "Title": title,
      "Subject": sub,
      "Class": clss,
      "Due": duedate,
      "PostedDate": date,
      "PostedBy": name,
      "MeetID": id,
      "Pass": pass,
      "UserId": uid,
      "DocId": meetDocId,
    });
  }

  Stream<QuerySnapshot> getMeetingData() {
    try {
      return db
          .collection('DigiClass')
          .doc('Meeting')
          .collection('Teacher')
          .snapshots();
    } catch (e) {
      return null;
    }
  }

  Future deleteMeetingData(String meetDocId) async {
    try {
      await db
          .collection("DigiClass")
          .doc("Meeting")
          .collection("Teacher")
          .doc(meetDocId)
          .delete()
          .then((value) => print("Deleted Successfully"))
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
  }

  //Student Meet details
  Future studentAttendance(
      String meetDocId,
      String userId,
      String name,
      String rollNo,
      String clss,
      String meetJoind,
      String title,
      String subject,
      String postedBy,
      String postedDate) async {
    String meetLeave = "";
    bool attended = false;
    try {
      attended = true;
      db
          .collection('DigiClass')
          .doc('Attendance')
          .collection('Student')
          .doc(userId)
          .collection('Meeting')
          .doc(meetDocId)
          .set({
        "StudentId": userId,
        "MeetDocId": meetDocId,
        "Class": clss,
        "MeetJoined": meetJoind,
        "MeetLeave": meetLeave,
        "Title": title,
        "Subject": subject,
        "PostedBy": postedBy,
        "PostedDate": postedDate,
        "Attended": attended
      });
    } catch (e) {
      print(e);
    }
    try {
      attended = true;
      db
          .collection('DigiClass')
          .doc('Meeting')
          .collection('Student')
          .doc(meetDocId)
          .collection('Attendance')
          .doc(userId)
          .set({
        "StudentId": userId,
        "MeetDocId": meetDocId,
        "Name": name,
        "RollNo": rollNo,
        "Class": clss,
        "MeetJoined": meetJoind,
        "MeetLeave": meetLeave,
        "Attended": attended
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> getStudentAttendance() {
    return db
        .collection('DigiClass')
        .doc('Attendance')
        .collection('Student')
        .doc(currentUserUid)
        .collection('Meeting')
        .snapshots();
  }

  Stream<QuerySnapshot> getMeetStudentAttendance(String meetId) {
    return db
        .collection('DigiClass')
        .doc('Meeting')
        .collection('Student')
        .doc(meetId)
        .collection('Attendance')
        .snapshots();
  }

  Future updatemeetLeave(String meetId, DateTime leaveDate) async {
    String formattedDate;
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(leaveDate);
    await db
        .collection("DigiClass")
        .doc('Meeting')
        .collection('Student')
        .doc(meetId)
        .collection('Attendance')
        .doc(currentUserUid)
        .update({
      "MeetLeave": formattedDate,
    });

    await db
        .collection("DigiClass")
        .doc('Attendance')
        .collection('Student')
        .doc(currentUserUid)
        .collection('Meeting')
        .doc(meetId)
        .update({
      "MeetLeave": formattedDate,
    });
  }

  //Add attendance Teacher
  Future<void> addTeacherAttendance(
      String userId,
      String attendanceSub,
      String title,
      String clss,
      List<File> filesList,
      String name,
      String date) async {
    String id = db
        .collection('DigiClass')
        .doc('Attendance')
        .collection("Teacher")
        .doc()
        .id;
    String fileName = filesList[0].path.split('/').last;
    final img = await st
        .ref()
        .child('Attendance/Teacher/$id/$fileName')
        .putFile(filesList[0]);
    String url = "";
    if (img != null) {
      try {
        url = await img.ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      print("No file found");
    }

    db
        .collection('DigiClass')
        .doc('Attendance')
        .collection("Teacher")
        .doc(id)
        .set({
      "userId": userId,
      "SubAttendance": attendanceSub,
      "AttendanceDocs": url,
      "Title": title,
      "id": id,
      "docName": fileName,
      "Class": clss,
      "postedBy": name,
      "date": date,
    });
  }

  Stream<QuerySnapshot> getAttendanceSheet() {
    return db
        .collection('DigiClass')
        .doc('Attendance')
        .collection("Teacher")
        .snapshots();
  }

  Future deleteAttendanceSheet(var attenddata) async {
    await deleteAttendanceSheetFile(attenddata);
    await db
        .collection("DigiClass")
        .doc("Attendance")
        .collection("Teacher")
        .doc(attenddata['id'])
        .delete()
        .then((value) => print("Deleted Successfully"))
        .catchError((onError) => print(onError));
  }

  Future deleteAttendanceSheetFile(var attendData) async {
    print("Attendance/Teacher/${attendData['id']}/${attendData['docName']}");
    try {
      await st
          .ref()
          .child(
              "Attendance/Teacher/${attendData['id']}/${attendData['docName']}")
          .delete()
          .then((_) => print(
              'Successfully deleted ${attendData['docName']} storage item'));
    } catch (e) {
      print(e);
    }
  }
}
