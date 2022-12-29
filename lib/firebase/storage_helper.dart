import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plxn_task/core/snackbar_helper.dart';
import 'package:plxn_task/core/user_controller.dart';

class StorageHelper{
  final controller = Get.find<UserController>();
  static final storageInstance = FirebaseStorage.instance;

  Future<void> uploadImage({
    bool shootPic = true,
  }) async {
    /*
    type
    1 -> Profile picture
    2 -> Drop
    3 -> Spot
    */
    try {
      final ImagePicker picker = ImagePicker();
      var image = await picker.pickImage(
        source: shootPic ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1080,
        maxWidth: 1080,
        preferredCameraDevice: CameraDevice.front,
      );

      Reference reference = storageInstance.ref().child('picture/${DateTime.now()}');

      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        compressQuality: 30,
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
            statusBarColor: Colors.greenAccent,
            toolbarColor: Colors.greenAccent,
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true,
            initAspectRatio: CropAspectRatioPreset.square,
          ),
          IOSUiSettings(
            aspectRatioPickerButtonHidden: true,
            showCancelConfirmationDialog: true,
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      File file = File(croppedImage?.path ?? '/DCIM/Camera');

      final uploadTask = reference.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        controller.imageUploadProgress.value =
        '${event.bytesTransferred.toDouble() / event.totalBytes.toDouble()}';
      });

      final snapshot = await uploadTask.whenComplete(() => null);
      var urlDownloadWToken = await snapshot.ref.getDownloadURL();

      var urlDownload =
      urlDownloadWToken.replaceAll(RegExp(r'&token=[^\]]*$'), '');
      file.delete();
      log(urlDownload);

      SnackBarHelper.successMsg(msg: 'Image Uploaded Successfully.');
      controller.imageUrl.value = urlDownload;
      controller.imageUploadProgress.value = '';
    } on FirebaseException catch (e) {
      log(e.toString());
      SnackBarHelper.errorMsg(msg: 'Some unexpected error occurred.');
    } catch (e) {
      log(e.toString());
      SnackBarHelper.errorMsg(msg: 'Some unexpected error occurred.');
    }
  }
}