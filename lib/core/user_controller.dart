import 'package:get/get.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/core/dummy.dart';
import 'package:plxn_task/firebase/firestore_helper.dart';
import 'package:plxn_task/models/user.dart';

class UserController extends GetxController{
  UserModel newUser = Dummy.model;
  var imageUploadProgress = ''.obs;
  var imageUrl = ''.obs;
  final List<UserModel> userList = [];
  bool loading = false;
  int index = 1;

  void moveToIndex(int value){
    index = value;
    update([AppConstants.navBarIndexTag]);
  }

  Future<void> getData() async{
    loading = true;
    update([AppConstants.spotListUpdateTag]);
    userList.clear();
    await FirestoreHelper().getData();
    loading = false;
    update([AppConstants.spotListUpdateTag]);
  }
}