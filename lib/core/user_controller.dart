import 'package:get/get.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/models/user.dart';

class UserController extends GetxController{
  late UserModel newUser;
  var imageUploadProgress = ''.obs;
  var imageUrl = ''.obs;
  final List<UserModel> userList = [];
  bool loading = false;
  int index = 0;

  void moveToIndex(int value){
    index = value;
    update([AppConstants.navBarIndexTag]);
  }
}