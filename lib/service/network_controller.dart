import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      return _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.dialog(
          barrierDismissible: false,
          CupertinoAlertDialog(
            actions: [
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(Get.overlayContext!).pop();
                  initConnectivity();
                },
                child: const Text("Retry"),
              )
            ],
            title: const Text('No Connection'),
            content: const Text('Please check your internet connectivity!',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
          ));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
