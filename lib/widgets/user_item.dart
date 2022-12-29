import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plxn_task/models/user.dart';
import 'package:plxn_task/screens/user_details_screen.dart';
import 'package:resize/resize.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: ()=>Get.to(()=>UserDetailsScreen(user: user)),
      child: Container(
        width: screenSize.width,
        margin: EdgeInsets.symmetric(vertical: 5.sp),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(13.sp),
          border: Border.all(
            width: 3.sp,
            color: Colors.greenAccent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: user.email,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13.sp),
                child: CachedNetworkImage(
                  imageUrl: user.image,
                  height: 100.sp,
                  width: 100.sp,
                ),
              ),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  user.email,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
