import 'package:school_management/services/Auth_services.dart';

Auth_services _auth = Auth_services();
Map<String, dynamic> assignmentusersdata;

Future<void> getassignmentuser() async {
  try {
    Map<String, dynamic> _assignmentusersdata =
        await _auth.getAssignmentUsers();
    assignmentusersdata = _assignmentusersdata;
  } catch (e) {}
}
