import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/auth.controller.dart';
import 'package:erpalerts/controllers/notice.controller.dart';
import 'package:erpalerts/controllers/updates.controller.dart';
import 'package:erpalerts/controllers/user.controller.dart';

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => NoticeController());
    Get.lazyPut(() => UpdatesController());
  }
}
