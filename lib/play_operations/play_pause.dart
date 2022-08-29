import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:heza/widgets/navigation_drawer.dart';





void playMusic({required index, required AssetsAudioPlayer assetsAudioplayer}) {
  assetsAudioplayer.playlistPlayAtIndex(index);
}
