import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_downloader/utils/downloadmanager.dart';

void showVideoOptions(context, video, videoNo, isPlaylist) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Center(child: Text("Select Video Quility!")),
          content: SizedBox(
            height: 180,
            width: 250,
            child: FutureBuilder(
              future: getVideoQuilityList(video.url),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            setController(isPlaylist);
                            downloadPlaylistVideo(video, videoNo, index);
                            Navigator.pop(context);
                          },
                          leading: const Icon(FontAwesomeIcons.youtube),
                          trailing:
                              const Icon(FontAwesomeIcons.download, size: 20),
                          title: Text(
                              quilityNameConvert(
                                  snapshot.data!.elementAt(index).toString()),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
          ),
        );
      });
}

String quilityNameConvert(String txt) {
  return '${txt.replaceAll(RegExp(r'[^0-9]'), '')}p';
}
