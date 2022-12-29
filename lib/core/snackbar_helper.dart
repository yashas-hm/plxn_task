import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class SnackBarHelper {
  static void successMsg({
    String title = '',
    required String msg,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: title == '' ? const SizedBox.shrink() : Text(title),
      messageText: Padding(
        padding: EdgeInsets.only(left: 18.sp),
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: title == '' ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
      borderRadius: 20.sp,
      borderWidth: 1.sp,
      borderColor: Colors.greenAccent,
      margin: EdgeInsets.all(15.sp),
      padding: EdgeInsets.all(13.sp),
      backgroundColor: Colors.white,
      shouldIconPulse: true,
      icon: Padding(
        padding: EdgeInsets.all(13.sp),
        child: Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.greenAccent,
          size: 45.sp,
        ),
      ),
    );
  }

  static void errorMsg({
    String title = '',
    required String msg,
    int duration = 2,
  }) {
    Get.snackbar(
      '',
      '',
      duration: Duration(seconds: duration),
      titleText: title == '' ? const SizedBox.shrink() : Text(title),
      messageText: Padding(
        padding: EdgeInsets.only(left: 18.sp),
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: title == '' ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
      borderRadius: 20.sp,
      borderWidth: 1.sp,
      borderColor: Colors.redAccent,
      margin: EdgeInsets.all(15.sp),
      padding: EdgeInsets.all(13.sp),
      backgroundColor: Colors.white,
      shouldIconPulse: true,
      icon: Padding(
        padding: EdgeInsets.all(13.sp),
        child: Icon(
          Icons.clear_rounded,
          color: Colors.redAccent,
          size: 45.sp,
        ),
      ),
    );
  }
}