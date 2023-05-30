import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_button.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("Trim Merge Ringtone",
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              customButton(
                  "Video Download",
                  FontAwesomeIcons.video,
                  const Color.fromARGB(255, 21, 0, 105),
                  const Color.fromARGB(255, 146, 13, 255),
                  context,
                  1),
              customButton(
                  "Playlist Download",
                  FontAwesomeIcons.music,
                  const Color.fromARGB(255, 37, 193, 255),
                  const Color.fromARGB(255, 47, 0, 237),
                  context,
                  2),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              customButton(
                  "Download List",
                  FontAwesomeIcons.download,
                  const Color.fromARGB(255, 255, 32, 151),
                  const Color.fromARGB(255, 255, 169, 71),
                  context,
                  3),
              customButton(
                  "Share",
                  FontAwesomeIcons.share,
                  const Color.fromARGB(255, 0, 255, 136),
                  const Color.fromARGB(255, 0, 137, 161),
                  context,
                  4),
            ],
          ),
        ),
      ],
    );
  }
}
