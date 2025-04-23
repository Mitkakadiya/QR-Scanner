import 'package:get/get.dart';
import 'package:qr_scanner/controller/homeController.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(HomeController(), permanent: true);
  }
}