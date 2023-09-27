import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  const TimelineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Text(
          'timeline_tab_title'.tr,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'TimelineView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
