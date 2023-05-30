import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../service/quility_options.dart';
import '../utils/constants.dart';
import '../utils/playlist_helper.dart';
import 'donwload_list.dart';

var controller = Get.find<PlaylistHelper>();
TextEditingController plylistUrlController = TextEditingController();

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                splashRadius: 24,
                onPressed: () {
                  Get.to(() => const DownloadPage());
                },
                icon: const Icon(Icons.download))
          ],
          title: const Text("Playlist Downloader"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(left: 1, right: 15),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffEEEEEE),
                          blurRadius: 50,
                          offset: Offset(0, 0))
                    ]),
                child: TextFormField(
                  autofocus: false,
                  controller: plylistUrlController,
                  keyboardType: TextInputType.url,
                  cursorColor: Colors.red,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon:
                        Icon(FontAwesomeIcons.youtube, color: Colors.red),
                    hintText: "Youtube Playlist Url...",
                  ),
                ),
              ),
            ),
            ///// SEARCH BTN
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: CupertinoButton(
                      onPressed: () {
                        if (plylistUrlController.text.trim() != "") {
                          controller.loading.value = true;
                          controller.newPlayList.clear();
                          downloadPlaylist(plylistUrlController.text.trim());
                        }
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      padding: const EdgeInsets.all(0),
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.red, Colors.pink]),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xfffEEEEE),
                                blurRadius: 50,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Obx(
                            () => controller.loading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : const Text(
                                    "Search",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.loaded.value
                ? const Text("Download List",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                : Container()),
            const SizedBox(
              height: 10,
            ),
            //// LISTVIEW
            Expanded(
              child: Obx(() => controller.loaded.value
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.newPlayList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2),
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(4),
                              leading: Image.network(
                                  "https://img.youtube.com/vi/${controller.newPlayList.elementAt(index).getVideo.id}/mqdefault.jpg"),
                              title: Center(
                                child: Text(
                                    controller.newPlayList
                                        .elementAt(index)
                                        .getVideo
                                        .title,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: controller.newPlayList
                                        .elementAt(index)
                                        .downloading
                                    ? const CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.downloading_outlined,
                                          size: 16,
                                          color: Colors.white,
                                        ))
                                    : controller.newPlayList
                                            .elementAt(index)
                                            .getCompleted
                                        ? const CircleAvatar(
                                            maxRadius: 12,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.done,
                                              size: 16,
                                              color: Colors.white,
                                            ))
                                        : IconButton(
                                            splashRadius: 24,
                                            onPressed: () {
                                              showVideoOptions(
                                                  context,
                                                  controller.newPlayList
                                                      .elementAt(index)
                                                      .getVideo,
                                                  index,
                                                  true);
                                            },
                                            icon: const Icon(Icons.download),
                                          ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: controller.newPlayList
                                        .elementAt(index)
                                        .getDownloadStart
                                    ? controller.newPlayList
                                            .elementAt(index)
                                            .getCompleted
                                        ? const Center(
                                            child: Text(
                                              "Completed!",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Center(
                                            child: LinearPercentIndicator(
                                              lineHeight: 12.0,
                                              percent: controller.newPlayList
                                                      .elementAt(index)
                                                      .getProgressBar
                                                      .toDouble() /
                                                  100,
                                              barRadius:
                                                  const Radius.circular(50),
                                              center: Text(
                                                "${controller.newPlayList.elementAt(index).getProgressBar}%",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                              progressColor: Colors.black,
                                            ),
                                          )
                                    : Container(),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container()),
            ),
          ]),
        ),
      ),
    );
  }
}
