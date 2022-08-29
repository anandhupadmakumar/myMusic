import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:heza/main.dart';
import 'package:heza/screens/home_screen_duplicate.dart';
import 'package:heza/screens/playlist_add_screen.dart';
import 'package:heza/screens/playlist_name_screen.dart';
import 'package:path/path.dart';

import '../db_functions/db_crud_function.dart';
import '../db_functions/music_modal_class.dart';
import '../screens/splash_screen.dart';

Future<void> bottomSheetPlaylist(
    context, int playlistNameIndex, playlistname) async {
  showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 33, 81, 88),
      // isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (BuildContext context, value, Widget? _) {
                var playlistSongIdList = box.get(playlistname);
                playlistSongIdList ??= [];

                log(playlistSongIdList.toString());

                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: (() {}),

                        leading: CircleAvatar(
                          maxRadius: 30,

                          backgroundImage:
                              AssetImage('assets/images/music logomp3.jpg'),
                          // backgroundImage: AssetImage(
                          //   widget.allAudios[index].metas.image!.path,
                          // ),

                          //AssetImage(audioList[index].metas.image!.path),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 41, 41, 41)
                                      .withOpacity(0.3),
                                  spreadRadius: 8,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                  songsFromDb[index].title!,

                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    playlistSongIdAdd(index,
                                        songsFromDb[index].id!, playlistname);
                                    favoriteSnackbar(context: context);
                                    playlistAudiolist(key: playlistname);

                                    // favoritebtnActionbottomSheet(index);
                                    // favoriteSnackbarbottomSheet(
                                    //     context: context);
                                    // favoriteAudioList();
                                    // addPlaylistSongsDb(
                                    //     index, playlistNameIndex, context);
                                  },
                                  icon: playlistSongIdList!
                                          .contains(songsFromDb[index].id)
                                      ? Icon(Icons.minimize_rounded)
                                      : Icon(Icons.add_circle_outline)),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              songsFromDb[index].album!,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(songsFromDb[index].duration,
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                        // trailing: Text(musicValueNotifier
                        //     .value[index].duration));
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(right: 20, top: 10, bottom: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      );
                    },
                    itemCount: songsFromDb.length);
              }),
        );
      });
}

// void addPlaylistSongsDb(index, playlistNameIndex, context) async {
//   List<MusicPlayListSongs> currentList = playListSongsDb.values.toList();
//   var contains = currentList.where((element) =>
//       element.names == playListNamesNotifier.value[playlistNameIndex].name &&
//       element.songs == songsFromDb[index].path);

//   if (contains.isEmpty) {
//     final listofPlaylistData = MusicPlayListSongs(
//         id: index,
//         songs: songsFromDb[index].path,
//         names: playListNamesNotifier.value[playlistNameIndex].name,
//         title: songsFromDb[index].title,
//         subtitle: songsFromDb[index].album,
//         duration: songsFromDb[index].duration);
//     await playListSongsDb.add(listofPlaylistData);

//     log(playListNames.toString());

//     playListSongsNotifier.value.add(listofPlaylistData);
//     playListSongsNotifier.notifyListeners();

//     log(playlistNameIndex.toString());
//     log(listofPlaylistData.songs.toString());
//     SnackBar playlistSnackbar = SnackBar(
//       content: Text('Song  added to playlist'),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
//     Navigator.of(context).pop();
//   } else {
//     SnackBar playlistSnackbar = SnackBar(
//       content: Text('Song already added to playlist'),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
//     Navigator.of(context).pop();
//   }

//   // final music = playListSongsDb.getAt(playlistNameIndex);
//   // log(music!.songs.toString());
// }

Future<void> bottomSheetPlaylistFavoirte(context) async {
  showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 33, 81, 88),
      // isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (BuildContext context, value, Widget? _) {
                final favoritesongsj = box.get('favorites');
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: (() {}),

                        leading: CircleAvatar(
                          maxRadius: 30,

                          backgroundImage:
                              AssetImage('assets/images/music logomp3.jpg'),
                          // backgroundImage: AssetImage(
                          //   widget.allAudios[index].metas.image!.path,
                          // ),

                          //AssetImage(audioList[index].metas.image!.path),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 41, 41, 41)
                                      .withOpacity(0.3),
                                  spreadRadius: 8,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                  songsFromDb[index].title!,

                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    favoriteIdAdd(
                                        songsFromDb[index].id!, index);
                                    favoriteSnackbar(context: context);

                                    // favoritebtnActionbottomSheet(index);
                                    // favoriteSnackbarbottomSheet(
                                    //     context: context);
                                    // favoriteAudioList();
                                    // addPlaylistSongsDb(
                                    //     index, playlistNameIndex, context);
                                  },
                                  icon: favoriteIdList
                                          .contains(songsFromDb[index].id)
                                      ? Icon(Icons.minimize_rounded)
                                      : Icon(Icons.add_circle_outline)),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              songsFromDb[index].album!,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(songsFromDb[index].duration,
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                        // trailing: Text(musicValueNotifier
                        //     .value[index].duration));
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(right: 20, top: 10, bottom: 10),
                        child: Divider(
                          thickness: 2,
                        ),
                      );
                    },
                    itemCount: songsFromDb.length);
              }),
        );
      });
}

void favoritebtnActionbottomSheet(index) {
  List result = favoriteIdList
      .where((element) => element == songsFromDb[index].id)
      .toList();

  if (result.isEmpty) {
    // final favoritedata = MusicFavorites(
    //     id: songsFromDb[index].id,
    //     path: songsFromDb[index].path,
    //     album: songsFromDb[index].album,
    //     title: songsFromDb[index].title,
    //     duration: songsFromDb[index].duration);
    // favoritesDb.add(favoritedata);
    // favoriteListNotifier.value.add(favoritedata);

    favoriteIdList.add(songsFromDb[index].id!);
    box.put('favorites', favoriteIdList);
    favoriteIdList = box.get('favorites') as List<int>;
    // favoriteSongsIdDb.sort(
    //   (b, a) => a.compareTo(b),
    // );

    log(favoriteIdList.toString());

    log(favoriteIdList.toString());

    log(result.toString());

    favorites = false;
  } else {
    favorites = true;
  }
}

favoriteSnackbarbottomSheet({
  required context,
}) {
  SnackBar showsnackbar;

  if (favorites == true) {
    showsnackbar = const SnackBar(
      content: Text(
        'Already added in favourites',
      ),
    );
    Navigator.of(context).pop();
  } else {
    showsnackbar = const SnackBar(
      content: Text(
        'Song added ',
      ),
    );
  }
  ScaffoldMessenger.of(context).showSnackBar(showsnackbar);
}
