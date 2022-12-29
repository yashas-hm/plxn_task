import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plxn_task/core/app_constants.dart';
import 'package:plxn_task/core/user_controller.dart';
import 'package:plxn_task/screens/add_info_screen.dart';
import 'package:plxn_task/screens/list_screen.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/fluid_nav_bar.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/fluid_nav_bar_icon.dart';
import 'package:plxn_task/widgets/bottom_nav_bar/fluid_nav_bar_style.dart';

class HomeScreen extends StatelessWidget {
 HomeScreen({Key? key}) : super(key: key);

 final controller = Get.find<UserController>();

  Widget pages(int index) {
    switch (index) {
      case 0:
        return ListViewScreen();
      case 1:
        return const AddUserScreen();
      default:
        return ListViewScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            GetBuilder(
              init: controller,
              id: AppConstants.navBarIndexTag,
              builder: (ctr) => pages(controller.index),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FluidNavBar(
                defaultIndex: controller.index,
                animationFactor: 0.5,
                style: const FluidNavBarStyle(
                  iconBackgroundColor: Colors.greenAccent,
                  barBackgroundColor: Colors.greenAccent,
                  iconSelectedForegroundColor: Colors.white,
                  iconUnselectedForegroundColor: Colors.white,
                ),
                icons: [
                  FluidNavBarIcon(
                    icon: Icons.list_alt_rounded
                  ),
                  FluidNavBarIcon(
                    icon: Icons.add_circle_outline_rounded,
                  ),
                ],
                onChange: (index) {
                  controller.moveToIndex(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
