import 'package:get/get.dart';

import '../controllers/newsfeed_controller.dart';

class NewsfeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsfeedController>(
      () => NewsfeedController(),
    );
  }
}
