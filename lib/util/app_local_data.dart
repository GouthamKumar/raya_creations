import 'package:raya_mobile/app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefVariables {

  static String USER_LOGIN_STATUS = 'loginStatus';
  static String USER_ID = 'userId';
  static String USER_NAME = 'userName';
  static String USER_PHONE = 'userPhone';
  static String USER_MAIL = 'userMail';
  static String USER_ROLE = 'userRole';
}

class GlobalValues {

  static String  GLOBAL_CONST_YES = 'YES';
  static String  GLOBAL_CONST_NO = 'NO';
  static String  GLOBAL_CONST_ACTIVE = 'ACTIVE';

  static bool  GLOBAL_CONST_TRUE = true;
  static bool  GLOBAL_CONST_FALSE = false;

  static bool  API_HOST_LIVE = false;
  static String  GLOBAL_CONST_EMPTY = '';
  static bool  IS_PRINT_LOG = true;
  static String  GLOBAL_CONST_ENTER_USER_NAME = 'Enter Username';
  static String  GLOBAL_CONST_ENTER_PASSWORD = 'Enter Password';
  static String  GLOBAL_CONST_ENTER_DEPOSIT = 'Enter Deposit Amount';
  static String  GLOBAL_CONST_ENTER_REMARKS = 'Enter Remarks';
  static String  GLOBAL_CONST_ENTER_WITHDRAW = 'Enter Withdraw Amount';
  static String  GLOBAL_CONST_ENTER_NAME = 'Enter Name';
  static String  GLOBAL_CONST_ENTER_PHONE = 'Enter Valid Phone Number';
  static String  GLOBAL_CONST_ENTER_SHARE = 'Enter SHARING PERCENTAGE';
  static String  GLOBAL_CONST_ENTER_ADDRESS = 'Enter Address';
  static String  GLOBAL_CONST_ENTER_PINCODE = 'Enter Pincode';
  static String  GLOBAL_CONST_ENTER_LANDMARK = 'Enter Landmark';
  static String  GLOBAL_CONST_ENTER_COMMENTS = 'Enter Comments';
}

saveUserDetails(User user) async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(AppPrefVariables.USER_ID, user.id);
  await sharedPreferences.setString(AppPrefVariables.USER_NAME, user.name);
  await sharedPreferences.setString(AppPrefVariables.USER_PHONE, user.phone ?? '');
  await sharedPreferences.setString(AppPrefVariables.USER_MAIL, user.email ?? '');
  await sharedPreferences.setString(AppPrefVariables.USER_ROLE, user.role_id ?? '');
}

loginStatus(String status) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(AppPrefVariables.USER_LOGIN_STATUS,status);
}

clearPref() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

Future<String?> isUserLoggedIn()  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(AppPrefVariables.USER_LOGIN_STATUS);
}

Future<String?> savedUserName()  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(AppPrefVariables.USER_NAME);
}



Future<String?> savedUserId()  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(AppPrefVariables.USER_ID)??"";
}

Future<String?> savedUserPhone()  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(AppPrefVariables.USER_PHONE);
}

Future<String?> savedUserMail()  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(AppPrefVariables.USER_MAIL);
}

Future<String?> savedUserRole()  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(AppPrefVariables.USER_ROLE)??"";
}