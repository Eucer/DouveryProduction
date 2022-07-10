import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1douvery/constantes/utils.dart';
import 'package:v1douvery/features/auth/screens/auth_screen.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      var future = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
