import 'package:flutter/material.dart';
import 'package:plxn_task/widgets/custom_appbar.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar('List of Users'),
    );
  }
}
