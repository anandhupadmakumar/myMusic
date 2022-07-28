import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_sample/play_operations/next_previous_function.dart';
import 'package:music_sample/screens/now_playing_screen.dart';

Widget playBar(RealtimePlayingInfos realtimePlayingInfos,
    AssetsAudioPlayer assetsAudioPlayer) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.compare_arrows_rounded),
        iconSize: 20,
        color: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () => assetsAudioPlayer.previous(),
        icon: Icon(Icons.fast_rewind_rounded),
        iconSize: 20,
        color: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () {
         
          assetsAudioPlayer.playOrPause();
        },
        icon: Icon(realtimePlayingInfos.isPlaying
            ? Icons.pause_circle_filled_rounded
            : Icons.play_circle_fill_rounded),
        iconSize: 20,
        color: Color.fromARGB(255, 206, 86, 86),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () => assetsAudioPlayer.next(),
        icon: Icon(Icons.fast_forward_rounded),
        iconSize: 20,
        color: Color.fromARGB(255, 206, 86, 86),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.autorenew_rounded),
        iconSize: 20,
        color: Color.fromARGB(255, 206, 86, 86),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    ],
  );
}
