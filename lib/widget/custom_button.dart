import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_downloader/pages/donwload_list.dart';
import 'package:video_downloader/pages/playlist_downloader.dart';

import '../pages/video_downloader.dart';

Widget customButton(text, icon, Color first, Color second, context, btnNo) {
  return CupertinoButton(
    onPressed: () {
      switch (btnNo) {
        case 1:
          Get.to(() => const VideoPage());
          break;
        case 2:
          Get.to(() => const PlaylistPage());
          break;
        case 3:
          Get.to(() => const DownloadPage());
          break;
        case 4:
          Get.showSnackbar(const GetSnackBar(
            padding: EdgeInsets.all(5),
            duration: Duration(seconds: 3),
            title: "Share this app!",
            message: "Nice to see! You want to share this app!",
            snackPosition: SnackPosition.BOTTOM,
          ));
          break;
      }
    },
    padding: const EdgeInsets.all(0),
    borderRadius: BorderRadius.circular(15),
    child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                first,
                second,
              ],
            )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40, color: Colors.white),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ))
            ])),
  );
}
