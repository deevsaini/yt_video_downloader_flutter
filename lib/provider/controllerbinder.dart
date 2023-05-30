import 'package:get/get.dart';

import '../service/network_controller.dart';
import '../service/permission_controller.dart';
import '../service/share_receive_controller.dart';
import '../utils/constants.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PermissionController());
    Get.put(YoutubeHelper());
    Get.put(PlaylistHelper());
    Get.put(NetworkController());
    Get.put(ShareReceiveController());
  }
}
