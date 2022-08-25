import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:music_sample/db_functions/music_modal_class.dart';

import 'package:music_sample/screens/home_screen_duplicate.dart';

import '../main.dart';
import '../screens/playlist_name_screen.dart';
import '../screens/splash_screen.dart';

ValueNotifier<List<Audio>> finalAudioListofAllSongs = ValueNotifier([]);

List<dynamic> favoriteIdList = [];
List<Audio> finalFavoriteAudioSongs = [];

List<dynamic> playlistSongIdList = [];
List<Audio> playlistAudioSongs = [];
List<MusicModel> finalSongListPlaylist = [];

favoriteIdAdd(int homeScreenId, index) async {
  List result = favoriteIdList
      .where((element) => element == songsFromDb[index].id)
      .toList();
  if (result.isEmpty) {
    favoriteIdList.add(homeScreenId);
    await box.put('favourites', favoriteIdList);
    favoriteIdList = box.get('favourites') as List<dynamic>;

    favoriteIdList.sort(
      (b, a) => a.compareTo(b),
    );
    favoriteIdList.sort(
      (b, a) => a.compareTo(b),
    );

    print(favoriteIdList.toString());
    favorites = false;
    favoriteAudioList();
  } else {
    favorites = true;
  }
}

favoriteSnackbar({
  required context,
}) {
  SnackBar showsnackbar;

  if (favorites == true) {
    showsnackbar = const SnackBar(
      content: Text(
        'Already added in favourites',
      ),
    );
  } else {
    showsnackbar = const SnackBar(
      content: Text(
        'Song added ',
      ),
    );
  }
  ScaffoldMessenger.of(context).showSnackBar(showsnackbar);
  favorites = false;
}

List<Audio> favoriteAudioList() {
  favoriteIdList = box.get('favourites') as List<dynamic>;
  favoriteIdList.sort(
    (b, a) => a.compareTo(b),
  );
  log("inside function ${favoriteIdList.toString()}");
  finalSongListFavorite = songsFromDb.where((element) {
    return favoriteIdList.contains(element.id);
  }).toList();

  for (var element in finalSongListFavorite) {
    finalFavoriteAudioSongs.add(Audio.file(element.path!,
        metas: Metas(
            title: element.title,
            artist: element.album,
            id: element.id.toString())));
  }

  // for (var i = 0; i < finalSongListFavorite.length; i++) {
  //   finalFavoriteAudioSongs.add(Audio.file(finalSongListFavorite[i].path!,
  //       metas: Metas(
  //         title: finalSongListFavorite[i].title,
  //         artist: finalSongListFavorite[i].album,
  //       )));
  // }
  // log("inside function song${finalFavoriteAudioSongs[1].path}");
 

  return finalFavoriteAudioSongs;
}

playlistSongIdAdd(index, playListSongsid, key) async {
  final result = playlistSongIdList
      .where((element) => element == songsFromDb[index].id)
      .toList();
  if (result.isEmpty) {
    playlistSongIdList = box.get(key) as List<dynamic>;
    playlistSongIdList.add(playListSongsid);
    await box.put(key, playlistSongIdList);

    playlistSongIdList.sort(
      (b, a) => a.compareTo(b),
    );
    print(playlistSongIdList.toString());
    favorites = false;
  } else {
    favorites = true;
    print('object');
  }
}

List<MusicModel> playlistAudiolist({required key}) {
  final playlistSongIdList = box.get(key);

  if (playlistSongIdList != null) {
    finalSongListPlaylist = songsFromDb.where((element) {
      return playlistSongIdList.contains(element.id);
    }).toList();
    for (var i = 0; i < playlistSongIdList.length; i++) {
      playlistAudioSongs.add(Audio.file(finalSongListPlaylist[i].path!,
          metas: Metas(
            title: finalSongListPlaylist[i].title,
            artist: finalSongListPlaylist[i].album,
          )));
    }
  }
  return finalSongListPlaylist;
}

void playlistNameEdit(context, index, playlistNameEdit) {
  final playlistSongid = box.get(playlistNameEdit);
  final playlistNamesFromDb = box.get('playlist_name');
  final playListNamesController = TextEditingController();
  playListNamesController.text = playlistNameEdit;
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit playlist '),
          content: Form(
            child: TextFormField(
              controller: playListNamesController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  if (playListNamesController.text.isEmpty ||
                      playListNamesController.text == 'favorite') {
                    SnackBar playlistSnackbar = const SnackBar(
                      content: Text('Enter a valid name'),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(playlistSnackbar);
                    Navigator.of(context).pop();
                    playListNamesController.clear();
                  } else {
                    var a = playlistNamesFromDb!.where(
                        (element) => element == playListNamesController.text);
                    if (a.isEmpty) {
                      playlistNamesFromDb.removeAt(index);
                      playlistNamesFromDb.insert(
                          index, playListNamesController.text);

                      box.put('playlist_name', playlistNamesFromDb);
                      box.put(playListNamesController.text, playlistSongid!);

                      playListNamesController.clear();
                      Navigator.of(context).pop();
                    } else {
                      SnackBar playlistSnackbar = const SnackBar(
                        content: Text('playlist name is already exist'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(playlistSnackbar);
                      Navigator.of(context).pop();
                      playListNamesController.clear();
                    }
                  }
                },
                child: Text('Ok'))
          ],
        );
      });
}

void deletePopupFavorite(context, index) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do you want to delete ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel')),
            TextButton(
                onPressed: () async {
                  favoriteIdList.remove(finalSongListFavorite[index].id);
                  finalSongListFavorite.remove(finalSongListFavorite[index]);
                  box.put('favourites', favoriteIdList);
                  finalFavoriteAudioSongs.clear();
                  finalFavoriteAudioSongs = favoriteAudioList();
                  // audioPlayer.playlistAudioFinished.listen((event) async {
                  //   event.audio.audio.currentlyOpenedIn.;
                  //   await play(audioPlayer, finalFavoriteAudioSongs, index);

                  // });
                  if (audioPlayer.playerState.hasValue) {
                    await play(audioPlayer, finalFavoriteAudioSongs, index);
                  }

                  Navigator.of(context).pop();
                },
                child: Text('Yes')),
          ],
        );
      });
}

void deletePopupPlaylistName(context, index) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do you want to delete ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () {
                  box.delete(playlistNames[index]);
                  playlistNames.removeAt(index);
                  box.put('playlist_name', playlistNames);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
          ],
        );
      });
}

void deletePopupPlaylistSongs(context, index, playlistNameIndex) {
  List playlistNames = box.get('playlist_name') as List;
  List playListSongIdList = box.get(playlistNames[playlistNameIndex]) as List;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do you want to delete ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () {
                  print('data');
                  playListSongIdList.removeAt(index);
                  box.put(playlistNames[playlistNameIndex], playListSongIdList);
                  playlistSongIdList = box.get(playlistNames[playlistNameIndex])
                      as List<dynamic>;
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
          ],
        );
      });
}
