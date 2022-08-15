import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_sample/main.dart';
import 'package:music_sample/screens/home_screen_duplicate.dart';
import 'package:music_sample/screens/playlist_add_screen.dart';
import 'package:path/path.dart';

import '../db_functions/db_crud_function.dart';
import '../db_functions/music_modal_class.dart';
import '../screens/splash_screen.dart';

Future<void> bottomSheetPlaylist(context, int playlistNameIndex) async {
  showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 33, 81, 88),
      // isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: ValueListenableBuilder(
              valueListenable: musicValueNotifier,
              builder:
                  (BuildContext context, List<MusicModel> value, Widget? _) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: (() {}),
                        // onTap: () {
                        //   // if (audioPlayer.current.value !=
                        //   //     null) {
                        //   //   audioPlayer.stop();
                        //   // }else{
                        //   audioPlayer
                        //       .playlistPlayAtIndex(index);

                        //   // playMusic(index: index, assetsAudioplayer: assetAudioPlayer);

                        //   //   Navigator.of(context).push(MaterialPageRoute(
                        //   //     builder: (context) {
                        //   //       return DupeNowPlayingScreen(au
                        //   //         index: index,
                        //   //       );
                        //   //     },
                        //   //   )

                        //   //       //     builder: (ctx) =>
                        //   //       // NOwPlayingScreen(
                        //   //       //       realtimePlayingInfos: realtimePlayingInfos,
                        //   //       //       index: index,
                        //   //       //       assetsAudioPlayer: assetAudioPlayer,
                        //   //       //     ),
                        //   //       //   ),
                        //   //       );
                        // },
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
                                  musicValueNotifier.value[index].title,

                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  addPlaylistSongsDb(
                                      index, playlistNameIndex, context);
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              musicValueNotifier.value[index].album,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(musicValueNotifier.value[index].duration,
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
                    itemCount: finalSongList.length);
              }),
        );
      });
}

void addPlaylistSongsDb(index, playlistNameIndex, context) async {

    List<MusicPlayListSongs> currentList = playListSongsDb.values.toList();
    var contains =
        currentList.where((element) =>
         element.names == playListNamesNotifier.value[playlistNameIndex].name && 
        element.songs==musicValueNotifier.value[index].path);
    
  
 
  if (contains.isEmpty) {
    final listofPlaylistData = MusicPlayListSongs(
        id: index,
        songs: musicValueNotifier.value[index].path,
        names: playListNamesNotifier.value[playlistNameIndex].name,
        title: musicValueNotifier.value[index].title,
        subtitle: musicValueNotifier.value[index].album,
        duration: musicValueNotifier.value[index].duration);
    playListSongsDb.add(listofPlaylistData);

    log(playListNames.toString());

    playListSongsNotifier.value.add(listofPlaylistData);
    playListSongsNotifier.notifyListeners();

    log(playlistNameIndex.toString());
    log(listofPlaylistData.songs.toString());
    SnackBar playlistSnackbar = SnackBar(
      content: Text('Song  added to playlist'),
    );
    ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
    Navigator.of(context).pop();
  } else {
    SnackBar playlistSnackbar = SnackBar(
      content: Text('Song already added to playlist'),
    );
    ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
    Navigator.of(context).pop();
  }

  // final music = playListSongsDb.getAt(playlistNameIndex);
  // log(music!.songs.toString());
}
