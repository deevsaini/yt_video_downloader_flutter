import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'constants.dart';

final yt = YoutubeExplode();
// ignore: prefer_typing_uninitialized_variables
var controller;

void setController(playlist) {
  debugPrint("calles");
  if (playlist) {
    controller = Get.find<PlaylistHelper>();
    debugPrint("Done");
  } else {
    controller = Get.find<YoutubeHelper>();
  }
}

Future<Set> getVideoQuilityList(videoUrl) async {
  var manifest = await yt.videos.streamsClient.getManifest(videoUrl);
  var video = manifest.muxed.getAllVideoQualities();
  return video;
}

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

downloadPlaylistVideo(Video videoD, index, quilityNo) async {
  try {
    var manifest = await yt.videos.streamsClient.getManifest(videoD.url);
    var video = manifest.muxed.elementAt(quilityNo);
    var fileName =
        '${videoD.title}${DateTime.now().millisecondsSinceEpoch}.${video.container.name.toString()}'
            .replaceAll(r'\', '')
            .replaceAll('/', '')
            .replaceAll('*', '')
            .replaceAll(':', '')
            .replaceAll('?', '')
            .replaceAll('"', '')
            .replaceAll('<', '')
            .replaceAll('>', '')
            .replaceAll('|', '');
    var vidStream = yt.videos.streamsClient.get(video);
    if ((await requestPermission(Permission.videos) &&
            await requestPermission(Permission.audio)) ||
        await requestPermission(Permission.storage)) {
      Directory dir =
          Directory('/storage/emulated/0/Download/YoutubeDownloader');

      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      var file = File('${dir.path}/$fileName');
      if (file.existsSync()) {}

      controller.newPlayList.elementAt(index).setDownloadStart(true);
      controller.newPlayList.elementAt(index).setDownloading(true);
      controller.newPlayList.refresh();
      var fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
      var len = video.size.totalBytes;
      var count = 0;
      await for (final data in vidStream) {
        count += data.length;
        var progress = ((count / len) * 100).ceil();
        controller.newPlayList.elementAt(index).setProgressBar(progress);
        controller.newPlayList.refresh();
        fileStream.add(data);
      }
      controller.newPlayList.elementAt(index).setDownloading(false);
      controller.newPlayList.elementAt(index).setCompleted(true);
      await fileStream.flush();
      await fileStream.close();
    }
  } catch (e) {
    e.printError();
  }
}
