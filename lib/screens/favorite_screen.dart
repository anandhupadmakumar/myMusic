import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_sample/db_functions/db_crud_function.dart';
import 'package:music_sample/screens/splash_screen.dart';

import 'package:music_sample/widgets/theme_color.dart';

import '../db_functions/music_modal_class.dart';
import '../db_functions/playfunction.dart';
import '../main.dart';
import '../widgets/bottom_sheet_mp_list.dart';
import '../widgets/realtime_listview.dart';
import 'home_screen_duplicate.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        body:
            // themeBlue(),
            // themePink(),
            Stack(
          fit: StackFit.expand,
          children: [
            themeBlue(),
            themePink(),
            Positioned(
              top: 0,
              child: InkWell(
                onTap: (() {
                  bottomSheetPlaylistFavoirte(context);
                }),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.only(left: 40, top: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 14, 14, 14).withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(5, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromARGB(255, 2, 101, 114),
                        width: 2,
                      )),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 232, 74, 6),
                          size: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Add songs',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                ),
              ),
            ),

            // themecyan(),
            Positioned(
              top: 20.0,
              left: 20.0,
              right: 0.0,
              bottom: 80.0,
              child: SafeArea(
                child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (BuildContext context, Box<List<dynamic>> value,
                        Widget? _) {
                      final favouritesSongs = box.get('favourites');
                      log(favouritesSongs.toString());
                      List<Audio> FavoriteAudioSongs = favoriteAudioList();

                      return favouritesSongs!.isEmpty
                          ? SizedBox(
                              child: Text('no songs found'),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () async {
                                      FavoriteAudioSongs.clear();
                                      log(index.toString());
                                      await play(
                                          audioPlayer,
                                          FavoriteAudioSongs =
                                              favoriteAudioList(),
                                          index);
                                      log(FavoriteAudioSongs.toString());

                                      await audioPlayer
                                          .playlistPlayAtIndex(index);
                                    },
                                    onLongPress: () {
                                      deletePopupFavorite(context, index);

                                      favorites = false;
                                    },
                                    leading: CircleAvatar(
                                      maxRadius: 30,
                                      backgroundImage: const AssetImage(
                                          'assets/images/music logomp3.jpg'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 41, 41, 41)
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        // 'data',
                                        finalSongListFavorite[index].title!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    subtitle: Text(
                                      finalSongListFavorite[index].album!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          nowPlayerBottomSheetPlaylist(
                                              index, context);
                                        },
                                        icon: Icon(Icons.playlist_add)));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: 20, top: 10, bottom: 10),
                                  child: Column(
                                    children: const [
                                      Divider(
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: finalSongListFavorite.length);
                    }),
              ),
            ),
          ],
        ));
  }
}

Future<void> nowPlayerBottomSheetPlaylist(favoritesongId, context) async {
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
                final playlistNames = box.get('playlist_name') as List<dynamic>;
                print(playlistNames);
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          playlistSongIdAdd(
                              favoritesongId,
                              songsFromDb[favoritesongId].id,
                              playlistNames[index]);
                          // playlistAudiolist(key:  playlistNames[index]);
                        },
                        // onLongPress: () => setState(() {
                        //   playlistNames.removeAt(index);
                        //   box.put('playlist_name', playlistNames);

                        //   //playlist names deleting fun
                        // }),

                        // playMusic(index: index, assetsAudioplayer: assetAudioPlayer);

                        //   Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) {
                        //       return DupeNowPlayingScreen(au
                        //         index: index,
                        //       );
                        //     },
                        //   )

                        //       //     builder: (ctx) =>
                        //       // NOwPlayingScreen(
                        //       //       realtimePlayingInfos: realtimePlayingInfos,
                        //       //       index: index,
                        //       //       assetsAudioPlayer: assetAudioPlayer,
                        //       //     ),
                        //       //   ),
                        //       );

                        leading: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Material(
                            elevation: 18.0,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/playlist-app-icon-button-260nw-1906619590.png',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        ),

                        // backgroundImage: AssetImage(
                        //   widget.allAudios[index].metas.image!.path,
                        // ),

                        //AssetImage(audioList[index].metas.image!.path),

                        // title: Padding(
                        //   padding:
                        //       const EdgeInsets.only(bottom: 10),
                        //   child: Text(
                        //     //realtimePlayingInfos.current!.audio.audio.metas.title!,
                        //     // playListNamesNotifier
                        //     //     .value[index].name,

                        //     style: const TextStyle(
                        //         color: Colors.white,
                        //         overflow:
                        //             TextOverflow.ellipsis),
                        //   ),
                        // ),
                        title: Text(
                          playlistNames[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              // playlistNameEdit(context, index);
                            },
                            icon: const Icon(Icons.edit)),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10),
                        child: Column(
                          children: const [
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: playlistNames.length);
              }),
        );
      });
}
