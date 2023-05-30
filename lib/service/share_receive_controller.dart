import 'dart:async';

import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../utils/receive_helper.dart';

class ShareReceiveController extends GetxController {
  RxString sharedText = "".obs;
  StreamSubscription? _dataStreamSubscription;

  @override
  void onInit() {
    _dataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String text) {
      if (sharedText.value != "") {
        sharedText.value = "";
      }
      sharedText.value = text;

      checkLinkisYoutube(sharedText.value);
    });

    ReceiveSharingIntent.getInitialText().then((String? text) {
      if (text != null) {
        if (sharedText.value != "") {
          sharedText.value = "";
        }
        sharedText.value = text;
        checkLinkisYoutube(sharedText.value);
      }
    });

    super.onInit();
  }

  @override
  void dispose() {
    _dataStreamSubscription?.cancel();
    super.dispose();
  }
}
