import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/core/snackbar_helper.dart';
import 'package:plxn_task/core/user_controller.dart';
import 'package:plxn_task/models/user.dart';

class FirestoreHelper {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  final controller = Get.find<UserController>();

  Future<void> addUser(UserModel user) async {
    bool error = false;
    await instance
        .collection(AppConstants.userCollection)
        .doc(user.email)
        .set(user.toJson())
        .onError(
          (error, stackTrace) {
            error = true;
            SnackBarHelper.errorMsg(msg: 'Some unexpected error occurred');
          }
        );
    if(!error){
      SnackBarHelper.successMsg(msg: 'Upload successful');
      controller.userList.add(user);
    }
  }
}
