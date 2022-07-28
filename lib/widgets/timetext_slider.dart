import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

Widget tmeStamp(RealtimePlayingInfos realtimePlayingInfos) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(transformString(realtimePlayingInfos.currentPosition.inSeconds)),
      Text(transformString(realtimePlayingInfos.duration.inSeconds),),
    ],


  );
}
String transformString(int seconds){
  String minuteString='${(seconds/60).floor()<10?0:''}${(seconds/60).floor()}';
  String scondString='${seconds%60<10?0:''}${seconds%60}';
  return '$minuteString:$scondString';
}
