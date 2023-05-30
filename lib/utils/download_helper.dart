import 'dart:async';

import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/playlistmodel.dart';
import 'constants.dart';

final yt = YoutubeExplode();
var _contr = Get.find<YoutubeHelper>();
Future download(String videoUrl) async {
  try {
    Video video = await yt.videos.get(videoUrl);
    PlayListModel listModel = PlayListModel();
    listModel.setVideo(video);
    _contr.newPlayList.add(listModel);
    _contr.newPlayList.refresh();
    _contr.loaded.value = true;
    _contr.loading.value = false;
  } catch (error) {
    _contr.loading.value = false;
    Get.showSnackbar(const GetSnackBar(
      title: "Invalid Video Url",
      message: "Invalid Youtube video ID or URL",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
