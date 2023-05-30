import 'package:get/get.dart';

import '../models/playlistmodel.dart';

class YoutubeHelper extends GetxController {
  RxBool loaded = false.obs;
  RxBool loading = false.obs;
  RxList<PlayListModel> newPlayList = RxList();
}

class PlaylistHelper extends GetxController {
  RxBool loaded = false.obs;
  RxBool loading = false.obs;
  RxList<PlayListModel> newPlayList = RxList();
}
