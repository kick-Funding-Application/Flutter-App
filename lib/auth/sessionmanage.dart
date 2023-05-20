import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String loggedInKey = 'isLoggedIn';

  // Check if the user is already logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey) ?? false;
  }

  // Save the login state
  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loggedInKey, value);
  }

  // Perform login action
  Future<void> login() async {
    // Perform your login logic here
    // After successful login, set the logged in state
    await setLoggedIn(true);
  }

  // Perform logout action
  Future<void> logout() async {
    // Perform your logout logic here
    // After successful logout, set the logged in state
    await setLoggedIn(false);
  }
}
