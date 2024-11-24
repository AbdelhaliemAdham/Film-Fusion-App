import 'package:get/get.dart';
import 'package:movie/data/add_to_watchList.dart';
import 'package:movie/data/auth_controller.dart';
import 'package:movie/data/user_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<UserController>(UserController());
    Get.put<AddToWatchList>(AddToWatchList(), permanent: true);
  }
}
