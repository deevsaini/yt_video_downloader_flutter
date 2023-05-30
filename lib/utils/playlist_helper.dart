import 'dart:async';

import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/playlistmodel.dart';
import 'constants.dart';

late dynamic fileName;
final yt = YoutubeExplode();
var _controller = Get.find<PlaylistHelper>();

Future downloadPlaylist(String playlistURL) async {
  try {
    var playlist = await yt.playlists.get(playlistURL);
    await for (var video in yt.playlists.getVideos(playlist.id)) {
      PlayListModel listModel = PlayListModel();
      listModel.setVideo(video);
      _controller.newPlayList.add(listModel);
    }
    _controller.newPlayList.refresh();
    _controller.loaded.value = true;
    _controller.loading.value = false;
  } catch (error) {
    _controller.loading.value = false;
    Get.showSnackbar(const GetSnackBar(
      title: "Invalid Video Url",
      message: "Invalid Youtube video ID or URL",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
