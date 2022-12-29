import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plxn_task/core/app_helpers.dart';
import 'package:plxn_task/screens/home_screen.dart';
import 'package:resize/resize.dart';

void main() async{
  await AppHelpers.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Resize(
      builder: () =>
          GetMaterialApp(
            defaultTransition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 500),
            debugShowCheckedModeBanner: false,
            theme: AppHelpers.appTheme(context),
            home: HomeScreen(),
          ),
      allowtextScaling: false,
      size: const Size(390, 844),
    );
  }
}
