import 'package:school_management/services/Auth_services.dart';

Auth_services _auth = Auth_services();
Map<String, dynamic> userdata;
Future<void> getCurrentData() async {
  try {
    Map<String, dynamic> _userData = await _auth.getCurrentUser();
    userdata = _userData;
  } catch (e) {
    print(e);
  }
}
