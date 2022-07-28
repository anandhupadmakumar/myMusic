import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_sample/widgets/home_listview.dart';
import 'package:music_sample/widgets/navigation_drawer.dart';

import '../widgets/realtime_listview.dart';



void playMusic({required index, required AssetsAudioPlayer assetsAudioplayer}) {
  assetsAudioplayer.playlistPlayAtIndex(index);
}
