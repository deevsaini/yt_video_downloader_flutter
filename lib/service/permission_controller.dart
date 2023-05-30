import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/downloadmanager.dart';

class PermissionController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initPermission();
  }

  Future<void> initPermission() async {
    try {
      if (Platform.isAndroid) {
        // Android-specific logic
        if ((await requestPermission(Permission.storage))) {
          Directory directory1 =
              Directory('/storage/emulated/0/Download/YoutubeDownloader');
          if (!directory1.existsSync()) {
            directory1.createSync();
          }
          Directory directory2 =
              Directory('/storage/emulated/0/Download/YoutubeDownloader/.temp');
          if (!directory2.existsSync()) {
            directory2.createSync();
          }
        }
      } else if (Platform.isIOS) {
        // iOS-specific logic
        if ((await requestPermission(Permission.photos) &&
                await requestPermission(Permission.microphone)) ||
            await requestPermission(Permission.photos)) {
          Directory tempDir = await getTemporaryDirectory();
          Directory directory1 = Directory('${tempDir.path}/YoutubeDownloader');
          if (!directory1.existsSync()) {
            directory1.createSync(recursive: true);
          }
          Directory directory2 =
              Directory('${tempDir.path}/YoutubeDownloader/.temp');
          if (!directory2.existsSync()) {
            directory2.createSync(recursive: true);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
