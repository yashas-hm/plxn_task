import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/core/app_helpers.dart';
import 'package:plxn_task/core/dummy.dart';
import 'package:plxn_task/core/user_controller.dart';
import 'package:plxn_task/firebase/firestore_helper.dart';
import 'package:plxn_task/firebase/storage_helper.dart';
import 'package:plxn_task/widgets/custom_appbar.dart';
import 'package:resize/resize.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  bool disable = false;
  bool loading = false;
  final controller = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar.customAppBar(
        'Add User Details',
        backEnabled: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.sp,
                ),
                SizedBox(
                  width: screenSize.width / 3,
                  height: screenSize.width / 3,
                  child: Stack(
                    children: [
                      Obx(
                        () {
                          return Stack(
                            children: [
                              ClipOval(
                                child: CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  radius: screenSize.width / 6,
                                  child: controller.imageUrl.value == ''
                                      ? Icon(
                                          Icons.person,
                                          size: 60.sp,
                                          color: Colors.white,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: controller.imageUrl.value,
                                          width: screenSize.width / 2,
                                          height: screenSize.width / 2,
                                          cacheKey: DateTime.now().toString(),
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: CircularProgressIndicator(
                                  value: controller
                                          .imageUploadProgress.value.isNotEmpty
                                      ? double.parse(
                                          controller.imageUploadProgress.value)
                                      : 0.0,
                                  strokeWidth: 5.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 35.sp,
                          width: 35.sp,
                          margin: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.sp),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () => showBottomModalSheet(
                            context,
                            screenSize,
                          ),
                          icon: Icon(
                            Icons.edit_rounded,
                            size: 25.sp,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    counterText: '',
                    labelStyle: const TextStyle(
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide:
                          BorderSide(width: 1.sp, color: Colors.greenAccent),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  cursorColor: Colors.greenAccent,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLength: 100,
                  maxLines: 1,
                  onChanged: (value) => controller.newUser.email = value.trim(),
                  validator: (value) {
                    if (value.toString().isNotEmpty) {
                      if (!AppHelpers.checkEmailRegex(value!.trim())) {
                        return 'invalid email address';
                      }
                    } else {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    counterText: '',
                    labelStyle: const TextStyle(
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide:
                          BorderSide(width: 1.sp, color: Colors.greenAccent),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  cursorColor: Colors.greenAccent,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  maxLines: 1,
                  onChanged: (value) => controller.newUser.phone = value.trim(),
                  validator: (value) {
                    if (value.toString().isNotEmpty) {
                      if (value.toString().length < 10) {
                        return 'invalid phone number';
                      }
                    } else {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Age',
                    counterText: '',
                    labelStyle: const TextStyle(
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide:
                          BorderSide(width: 1.sp, color: Colors.greenAccent),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  cursorColor: Colors.greenAccent,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  maxLines: 1,
                  onChanged: (value) =>
                      controller.newUser.age = int.parse(value.trim()),
                  validator: (value) {
                    if (value.toString().isNotEmpty) {
                      if (int.parse(value.toString()) < 10 &&
                          int.parse(value.toString()) > 100) {
                        return 'invalid age';
                      }
                    } else {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'GST Number',
                    counterText: '',
                    labelStyle: const TextStyle(
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide:
                          BorderSide(width: 1.sp, color: Colors.greenAccent),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  cursorColor: Colors.greenAccent,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLength: 60,
                  maxLines: 1,
                  onChanged: (value) =>
                      controller.newUser.gstNumber = value.trim(),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                DropdownButtonFormField(
                  items:
                      AppConstants.genders.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                            fontSize: 15.sp, color: Colors.greenAccent),
                      ),
                    );
                  }).toList(),
                  validator: (value) {
                    if (controller.newUser.gender.isEmpty) {
                      return 'select a gender';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      controller.newUser.gender = value.toString(),
                  value: 'Male',
                  decoration: InputDecoration(
                    labelText: 'GST Number',
                    counterText: '',
                    labelStyle: const TextStyle(
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                      borderSide:
                          BorderSide(width: 1.sp, color: Colors.greenAccent),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 60.sp,
                ),
                GestureDetector(
                  onTap: disable
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              disable = true;
                            });

                            controller.newUser.image = controller.imageUrl.value;

                            await FirestoreHelper().addUser(controller.newUser);

                            formKey.currentState!.reset();

                            controller.newUser = Dummy.model;

                            controller.imageUrl.value = '';

                            setState(() {
                              loading = false;
                              disable = false;
                            });
                          }
                        },
                  child: Container(
                    height: 50.sp,
                    width: screenSize.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.sp),
                      color: disable ? Colors.white38 : Colors.greenAccent,
                    ),
                    alignment: Alignment.center,
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomModalSheet(BuildContext context, Size screenSize) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.sp),
          topRight: Radius.circular(35.sp),
        ),
      ),
      builder: (ctx) => Container(
        height: screenSize.height / 3,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Choose image from:',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          disable = true;
                        });
                        Get.back();
                        await StorageHelper().uploadImage(
                          shootPic: true,
                        );
                        setState(() {
                          disable = false;
                        });
                      },
                      child: Container(
                        height: screenSize.height / 8,
                        width: screenSize.height / 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenSize.width),
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 3.sp,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.camera,
                          color: Colors.greenAccent,
                          size: screenSize.height / 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          disable = true;
                        });
                        Get.back();
                        await StorageHelper().uploadImage(
                          shootPic: false,
                        );
                        setState(() {
                          disable = false;
                        });
                      },
                      child: Container(
                        height: screenSize.height / 8,
                        width: screenSize.height / 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenSize.width),
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 3.sp,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.photo,
                          color: Colors.greenAccent,
                          size: screenSize.height / 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
