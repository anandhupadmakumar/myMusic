import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

import 'package:heza/screens/now_playing_screen_duplicate.dart';
import 'package:heza/widgets/iconbtn_widget.dart';

import '../db_functions/db_crud_function.dart';
import '../screens/home_screen_duplicate.dart';

bool songsSkip = true;

Widget bottomMiniPlayer({
  context,
  required AssetsAudioPlayer audioPlayer,
}) {
  final mpwidth = MediaQuery.of(context).size.width;
  final mpheight = MediaQuery.of(context).size.width;

  return SafeArea(
    child: audioPlayer.builderRealtimePlayingInfos(
      builder: ((context, RealtimePlayingInfos realtimePlayingInfos) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DupeNowPlayingScreen(
                  audioPlayer: audioPlayer,
                ),
              ),
            );
          },
          child: Container(
            width: mpwidth,
            height: mpheight * 0.2,
            color: Color.fromARGB(255, 50, 50, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: Color.fromARGB(255, 0, 94, 172),
                          backgroundImage:
                              AssetImage('assets/images/music logomp3.jpg'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textMoving(realtimePlayingInfos, context),
                            // Text(
                            //   realtimePlayingInfos
                            //       .current!.audio.audio.metas.artist!,
                            //   style: TextStyle(color: Colors.white),
                            // ),
                          ],
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            if (songsSkip) {
                              songsSkip = false;
                              await audioPlayer.previous();

                              songsSkip = true;
                            }
                          },
                          child: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            audioPlayer.playOrPause();
                          },
                          icon: Icon(realtimePlayingInfos.isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded),
                          iconSize: 40,
                          color: Color.fromARGB(255, 7, 225, 236),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            if (songsSkip) {
                              songsSkip = false;
                              await audioPlayer.next();

                              songsSkip = true;
                            }
                          },
                          child:
                              const Icon(Icons.skip_next, color: Colors.white),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}

Widget textMoving(RealtimePlayingInfos realtimePlayingInfos, context) {
  return Container(
    margin: EdgeInsets.only(left: 10),
    width: MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.width * 0.055,
    child: Marquee(
      pauseAfterRound: Duration(seconds: 0),
      velocity: 5,
      style: TextStyle(color: Colors.white),

      blankSpace: 30,
      crossAxisAlignment: CrossAxisAlignment.start,
      text: realtimePlayingInfos.current!.audio.audio.metas.title.toString(),
      // text Text(
      //   realtimePlayingInfos
      //       .current!.audio.audio.metas.title!,
      //   overflow: TextOverflow.clip,
      //   maxLines: 1,
      //   softWrap: false,
      //   style: TextStyle(
      //     color: Colors.white,
      //   ),
      // ),
    ),
  );
}
