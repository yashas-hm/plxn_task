import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plxn_task/core/user_controller.dart';
import 'package:plxn_task/firebase_options.dart';

class AppHelpers{
  static Future<void> initializeApp() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(UserController());
  }

  static ThemeData appTheme(BuildContext context) => ThemeData(
    primaryColor: Colors.greenAccent,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.greenAccent,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.greenAccent,
    ),
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.greenAccent,
      primary: Colors.greenAccent,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.transparent,
    ),
  );

  static bool checkEmailRegex(String value) {
    final regex = RegExp(
      r"^[a-z0-9!#$%&'*+\=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(value);
  }

}