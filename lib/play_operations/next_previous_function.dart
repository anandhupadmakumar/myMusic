import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_sample/widgets/home_listview.dart';

void next({required AssetsAudioPlayer assetsAudioplayer}) {
  assetsAudioplayer.next();
}

void previous({required AssetsAudioPlayer assetsAudioPlayer}) {
  assetsAudioPlayer.previous();
}
