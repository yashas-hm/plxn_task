import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plxn_task/models/user.dart';
import 'package:plxn_task/widgets/custom_appbar.dart';
import 'package:resize/resize.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.user,}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar.customAppBar(user.email),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: user.email,
              child: Container(
                color: Colors.greenAccent,
                height: screenSize.height/3,
                width: screenSize.width,
                child: CachedNetworkImage(
                  imageUrl: user.image,
                  width: screenSize.height/3,
                  height: screenSize.height/3,
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              width: screenSize.width,
              child: Text(
                user.email,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              width: screenSize.width,
              child: Text(
                user.phone,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              width: screenSize.width,
              child: Text(
                user.gstNumber,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              width: screenSize.width,
              child: Text(
                user.age.toString(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              width: screenSize.width,
              child: Text(
                user.gender,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
