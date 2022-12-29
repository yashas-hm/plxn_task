import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/models/user.dart';

class FirestoreHelper {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    await instance
        .collection(AppConstants.userCollection)
        .doc(user.email)
        .set(user.toJson())
        .onError((error, stackTrace) => null);
  }
}
