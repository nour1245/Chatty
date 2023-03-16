// import 'package:chatty_app/shared/components/components.dart';
// import 'package:chatty_app/shared/network/local/cash_helper.dart';
import 'package:chatty/modules/loginscreen.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/network/local/cash_helper.dart';
import 'package:hive/hive.dart';

// String? token = '';

late Box box;
String? uid;

signOut(context) {
  box.clear();
  uid = '';
  navigatAndReplace(context, LoginScreen());
}
