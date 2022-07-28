import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music_sample/widgets/theme_color.dart';

import '../widgets/realtime_listview.dart';

class FavoriteScreen extends StatelessWidget {
  final AssetsAudioPlayer assetaudioPlayer;
  List<String> audiolist;
   FavoriteScreen(
      {Key? key, required this.assetaudioPlayer,required this.audiolist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      body: Stack(
        children: [
          themeBlue(),
          themePink(),
          // realtimeHomeListview(assetaudioPlayer)
        ],
      ),
    );
  }
}
