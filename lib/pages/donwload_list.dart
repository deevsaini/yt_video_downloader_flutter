import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/video_helper.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download List"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: FutureBuilder(
              future: VideoHelper.getVideoFiles(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Card(
                            child: ListTile(
                                onTap: () {
                                  VideoHelper.launchInExternalPlayer(
                                      snapshot.data!.elementAt(index).path);
                                },
                                trailing: const CircleAvatar(
                                    maxRadius: 12,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.done,
                                      size: 16,
                                    )),
                                leading: FutureBuilder(
                                  future: VideoHelper.getVideoThumbnail(
                                      snapshot.data!.elementAt(index).path),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data! != '') {
                                        return Image(
                                            image: FileImage(
                                                File(snapshot.data!)));
                                      } else {
                                        return Image.asset(
                                            'assets/images/thumbnail.png');
                                      }
                                    } else {
                                      return Image.asset(
                                          'assets/images/loading.gif');
                                    }
                                  },
                                ),
                                title: Text(
                                  snapshot.data!
                                      .elementAt(index)
                                      .path
                                      .split('/')
                                      .last,
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: const Center(
                                  child: Text(
                                    "Completed!",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
