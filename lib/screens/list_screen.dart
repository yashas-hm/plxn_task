import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/core/user_controller.dart';
import 'package:plxn_task/widgets/custom_appbar.dart';
import 'package:plxn_task/widgets/user_item.dart';
import 'package:resize/resize.dart';

class ListViewScreen extends StatelessWidget {
  ListViewScreen({Key? key}) : super(key: key);

  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar('List of Users', backEnabled: false),
      body: Padding(
        padding: EdgeInsets.only(
          top: 10.sp,
          right: 10.sp,
          left: 10.sp,
          bottom: 60.sp,
        ),
        child: GetBuilder(
          init: controller,
          tag: AppConstants.spotListUpdateTag,
          builder: (ctr) => RefreshIndicator(
            onRefresh: () => controller.getData(),
            child: controller.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => UserItem(
                      user: controller.userList[index],
                    ),
                    itemCount: controller.userList.length,
                    shrinkWrap: true,
                  ),
          ),
        ),
      ),
    );
  }
}
