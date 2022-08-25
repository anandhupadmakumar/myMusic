

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';
import 'package:music_sample/screens/home_screen_duplicate.dart';


List<Audio>allAudioSongsFromLists=[];

Future<void> playSongs( List<MusicModel> audioSongs) async {



  for (var element in audioSongs) {
    allAudioSongsFromLists.add(Audio.file(element.path!,
        metas: Metas(
            title: element.title,
            artist: element.album,
            id: element.id.toString())));
  }


  await audioPlayer.open(
    Playlist(audios:allAudioSongsFromLists),
    showNotification:
        notification == null || notification == true ? true : false,
    autoStart: false,
    loopMode: LoopMode.playlist,
    // playInBackground: PlayInBackground.disabledRestoreOnForeground,
    // audioFocusStrategy:const AudioFocusStrategy.request(resumeAfterInterruption: true),

    notificationSettings: const NotificationSettings(stopEnabled: false),
  );
}



