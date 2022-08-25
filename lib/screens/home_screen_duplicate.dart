import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_sample/main.dart';
import 'package:music_sample/screens/playlist_add_screen.dart';
import 'package:music_sample/screens/playlist_name_screen.dart';
import 'package:music_sample/widgets/bottom_sheet_mp_list.dart';
import 'package:music_sample/widgets/iconbtn_widget.dart';

import '../db_functions/db_crud_function.dart';
import '../db_functions/music_modal_class.dart';
import '../widgets/bottom_sheet_miniplayer.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/theme_color.dart';
import 'favorite_screen.dart';
import 'splash_screen.dart';

List<MusicModel> finalSongListFavorite = [];
bool? notification;

bool favorites = false;
bool playlistvalidation = false;
final audioPlayer = AssetsAudioPlayer();
Future<void> play(AssetsAudioPlayer assetsaudioPlayer, List<Audio> audioSongs,
    int index) async {
  await assetsaudioPlayer.open(
    Playlist(audios: audioSongs, startIndex: index),
    showNotification:
        notification == null || notification == true ? true : false,
    autoStart: false,
    loopMode: LoopMode.playlist,
    // playInBackground: PlayInBackground.disabledRestoreOnForeground,
    // audioFocusStrategy:const AudioFocusStrategy.request(resumeAfterInterruption: true),

    notificationSettings: const NotificationSettings(stopEnabled: false),
  );
}

class HomeScreenDupe extends StatefulWidget {
  const HomeScreenDupe({Key? key}) : super(key: key);

  @override
  State<HomeScreenDupe> createState() => _HomeScreenDupeState();
}

class _HomeScreenDupeState extends State<HomeScreenDupe>
    with TickerProviderStateMixin {
  @override
  void initState() {
     favoriteAudioList();
    // favoriteAudioList();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomSheet(
            enableDrag: false,
            clipBehavior: Clip.antiAlias,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     top: Radius.circular(20),
            //   ),
            // ),
            onClosing: () {
              // true;
            },
            builder: (ctx) {
              return bottomMiniPlayer(
                context: context,
                audioPlayer: audioPlayer,
              );
            }),
        drawer: MpDrawer(
          audioPlayer: audioPlayer,
          value: notification,
        ),
        backgroundColor: const Color.fromARGB(255, 44, 43, 43),
        extendBody: true,
        body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      // snap: true,
                      actions: [
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: SongsSearch());
                            },
                            icon: const Icon(Icons.search)),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        // title: Text('MUSIC'),
                        centerTitle: true,
                        background: Image.asset(
                          'assets/images/dj.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      backgroundColor:
                          const Color.fromARGB(192, 3, 97, 116).withOpacity(1),
                      elevation: 0.0,
                      pinned: true,
                      floating: true,
                      expandedHeight: 150,
                      title: const Text('MUSIC'),
                      centerTitle: true,
                      bottom: const TabBar(tabs: [
                        Tab(
                          text: 'All Songs',
                        ),
                        Tab(
                          text: 'Playlist',
                        ),
                        Tab(
                          text: 'Favorite',
                        )
                      ]),
                    ),
                  ];
                },
                body: TabBarView(children: [
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      themeBlue(),
                      themePink(),
                      // themecyan(),
                      Positioned(
                        top: 0.0,
                        left: 20.0,
                        right: 0.0,
                        bottom: 80.0,
                        child: SafeArea(
                          child: ValueListenableBuilder(
                              valueListenable: box.listenable(),
                              builder:
                                  (BuildContext context, songlist, Widget? _) {
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: (() async {
                                          await play(audioPlayer, finalSongList,
                                              index);
                                          await audioPlayer
                                              .playlistPlayAtIndex(index);
                                        }),
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

                                          backgroundImage: const AssetImage(
                                              'assets/images/music logomp3.jpg'),
                                          // backgroundImage: AssetImage(
                                          //   widget.allAudios[index].metas.image!.path,
                                          // ),

                                          //AssetImage(audioList[index].metas.image!.path),
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
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                                songsFromDb[index].title!,

                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      nowPlayerBottomSheetPlaylist(
                                                          index, context);
                                                    },
                                                    icon: Icon(
                                                        Icons.playlist_add)),
                                                IconButton(
                                                  onPressed: () {
                                                    if (favoriteIdList.contains(
                                                        songsFromDb[index]
                                                            .id)) {
                                                      favoriteIdList.remove(
                                                          songsFromDb[index]
                                                              .id);
                                                      box.put('favourites',
                                                          favoriteIdList);
                                                    } else {
                                                      favoriteIdAdd(
                                                          songsFromDb[index]
                                                              .id!,
                                                          index);
                                                      favoriteSnackbar(
                                                          context: context);
                                                    }
                                                  },
                                                  icon: favoriteIdList.contains(
                                                          songsFromDb[index].id)
                                                      ? Icon(Icons.favorite,
                                                          key: Key(
                                                              'icon key $index'),
                                                          color:
                                                              Colors.redAccent)
                                                      : Icon(Icons
                                                          .favorite_border),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                                songsFromDb[index].album!,

                                                style: TextStyle(
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Text(songsFromDb[index].duration)
                                          ],
                                        ),

                                        // trailing: Text(musicValueNotifier
                                        //     .value[index].duration));
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                        thickness: 2,
                                      );
                                    },
                                    itemCount: songsFromDb.length);
                              }),
                        ),

                        //  HomeListView(assetsAudioplayer: assetsaudioPlayer,),
                      ),

                      // Positioned(
                      //   top: 40.0,
                      //   child: SizedBox(
                      //       width: MediaQuery.of(context).size.width * 1,
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.max,
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           iconBtn(() {}, Icons.refresh_outlined),
                      //           iconBtn(() {
                      //             // Navigator.of(context).push(MaterialPageRoute(
                      //             //     builder: (ctx) => FavoriteScreen(
                      //             //           assetaudioPlayer: audioPlayer,
                      //             //           audiolist: widget.allAudios,
                      //             //         )));
                      //           }, Icons.favorite),
                      //           iconBtn(() {
                      //             // Navigator.of(context)
                      //             //     .push(MaterialPageRoute(builder: (ctx) {
                      //             //   return PlayListScreen(
                      //             //       assetsaudioPlayer: audioPlayer,
                      //             //       audioLists: widget.allAudios);
                      //             // }));
                      //           }, Icons.playlist_add),
                      //         ],
                      //       )),
                      // ),
                    ],
                  ),
                  //playlist listview
                  // Stack(
                  //   fit: StackFit.expand,
                  //   children: [
                  //     themeBlue(),
                  //     themePink(),
                  //     Positioned(
                  //       top: 0,
                  //       child: InkWell(
                  //         onTap: (() {
                  //           // addPlaylistForm(context);
                  //         }),
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width * 0.85,
                  //           margin: EdgeInsets.only(left: 40, top: 20),
                  //           decoration: BoxDecoration(
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Color.fromARGB(255, 14, 14, 14)
                  //                       .withOpacity(0.1),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 2,
                  //                   offset: const Offset(5, 2),
                  //                 ),
                  //               ],
                  //               borderRadius: BorderRadius.circular(5),
                  //               border: Border.all(
                  //                 color: Color.fromARGB(255, 2, 101, 114),
                  //                 width: 2,
                  //               )),
                  //           child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: const [
                  //                 Icon(
                  //                   Icons.add,
                  //                   color: Color.fromARGB(255, 232, 74, 6),
                  //                   size: 40,
                  //                 ),
                  //                 Padding(
                  //                   padding: EdgeInsets.all(10.0),
                  //                   child: Text(
                  //                     'Create Playlist',
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ),
                  //               ]),
                  //         ),
                  //       ),
                  //     ),
                  //     // themecyan(),
                  //     Positioned(
                  //       top: 20.0,
                  //       left: 20.0,
                  //       right: 0.0,
                  //       bottom: 80.0,
                  //       child: SafeArea(
                  //         child: ValueListenableBuilder(
                  //             valueListenable: box.listenable(),
                  //             builder:
                  //                 (BuildContext context, value, Widget? _) {
                  //               return ListView.separated(
                  //                   itemBuilder: (context, index) {
                  //                     return ListTile(
                  //                       onTap: () {
                  //                         // Navigator.of(context).push(
                  //                         //   // MaterialPageRoute(
                  //                         //   //   builder: (ctx) =>
                  //                         //   //   //     MyPlaylistScreen(
                  //                         //   //   //   index: index,
                  //                         //   //   // ),
                  //                         //   // ),
                  //                         // );
                  //                       },
                  //                       onLongPress: () => setState(() {
                  //                         //playlist names deleting fun
                  //                       }),

                  //                       // playMusic(index: index, assetsAudioplayer: assetAudioPlayer);

                  //                       //   Navigator.of(context).push(MaterialPageRoute(
                  //                       //     builder: (context) {
                  //                       //       return DupeNowPlayingScreen(au
                  //                       //         index: index,
                  //                       //       );
                  //                       //     },
                  //                       //   )

                  //                       //       //     builder: (ctx) =>
                  //                       //       // NOwPlayingScreen(
                  //                       //       //       realtimePlayingInfos: realtimePlayingInfos,
                  //                       //       //       index: index,
                  //                       //       //       assetsAudioPlayer: assetAudioPlayer,
                  //                       //       //     ),
                  //                       //       //   ),
                  //                       //       );

                  //                       leading: Container(
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .height *
                  //                             0.1,
                  //                         width: MediaQuery.of(context)
                  //                                 .size
                  //                                 .width *
                  //                             0.15,
                  //                         child: Material(
                  //                           elevation: 18.0,
                  //                           color: Colors.transparent,
                  //                           borderRadius:
                  //                               BorderRadius.circular(50.0),
                  //                           child: ClipRRect(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(50.0),
                  //                             child: Image.asset(
                  //                               'assets/images/playlist-app-icon-button-260nw-1906619590.png',
                  //                               fit: BoxFit.cover,
                  //                               filterQuality:
                  //                                   FilterQuality.high,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),

                  //                       // backgroundImage: AssetImage(
                  //                       //   widget.allAudios[index].metas.image!.path,
                  //                       // ),

                  //                       //AssetImage(audioList[index].metas.image!.path),

                  //                       // title: Padding(
                  //                       //   padding:
                  //                       //       const EdgeInsets.only(bottom: 10),
                  //                       //   child: Text(
                  //                       //     //realtimePlayingInfos.current!.audio.audio.metas.title!,
                  //                       //     // playListNamesNotifier
                  //                       //     //     .value[index].name,

                  //                       //     style: const TextStyle(
                  //                       //         color: Colors.white,
                  //                       //         overflow:
                  //                       //             TextOverflow.ellipsis),
                  //                       //   ),
                  //                       // ),
                  //                       trailing: IconButton(
                  //                           onPressed: () {
                  //                             // playlistNameEdit(context, index);
                  //                           },
                  //                           icon: const Icon(Icons.edit)),
                  //                     );
                  //                   },
                  //                   separatorBuilder:
                  //                       (BuildContext context, int index) {
                  //                     return Padding(
                  //                       padding: const EdgeInsets.only(
                  //                           right: 20, top: 10, bottom: 10),
                  //                       child: Column(
                  //                         children: const [
                  //                           Divider(
                  //                             thickness: 2,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     );
                  //                   },
                  //                   itemCount: 5);
                  //             }),
                  //       ),

                  //       //  HomeListView(assetsAudioplayer: assetsaudioPlayer,),
                  //     ),

                  //     // Positioned(
                  //     //   top: 40.0,
                  //     //   child: SizedBox(
                  //     //       width: MediaQuery.of(context).size.width * 1,
                  //     //       child: Row(
                  //     //         mainAxisSize: MainAxisSize.max,
                  //     //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     //         children: [
                  //     //           iconBtn(() {}, Icons.refresh_outlined),
                  //     //           iconBtn(() {
                  //     //             // Navigator.of(context).push(MaterialPageRoute(
                  //     //             //     builder: (ctx) => FavoriteScreen(
                  //     //             //           assetaudioPlayer: audioPlayer,
                  //     //             //           audiolist: widget.allAudios,
                  //     //             //         )));
                  //     //           }, Icons.favorite),
                  //     //           iconBtn(() {
                  //     //             // Navigator.of(context)
                  //     //             //     .push(MaterialPageRoute(builder: (ctx) {
                  //     //             //   return PlayListScreen(
                  //     //             //       assetsaudioPlayer: audioPlayer,
                  //     //             //       audioLists: widget.allAudios);
                  //     //             // }));
                  //     //           }, Icons.playlist_add),
                  //     //         ],
                  //     //       )),
                  //     // ),
                  //   ],
                  // ),

                  PlayListNameScreen(),
                  FavoriteScreen(),

                  //favorite list
                  // Stack(
                  //   fit: StackFit.expand,
                  //   children: [
                  //     themeBlue(),
                  //     themePink(),
                  //     Positioned(
                  //       top: 0,
                  //       child: InkWell(
                  //         onTap: (() {
                  //           bottomSheetPlaylistFavoirte(context);
                  //         }),
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width * 0.85,
                  //           margin: EdgeInsets.only(left: 40, top: 20),
                  //           decoration: BoxDecoration(
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Color.fromARGB(255, 14, 14, 14)
                  //                       .withOpacity(0.1),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 2,
                  //                   offset: const Offset(5, 2),
                  //                 ),
                  //               ],
                  //               borderRadius: BorderRadius.circular(5),
                  //               border: Border.all(
                  //                 color: Color.fromARGB(255, 2, 101, 114),
                  //                 width: 2,
                  //               )),
                  //           child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: const [
                  //                 Icon(
                  //                   Icons.add,
                  //                   color: Color.fromARGB(255, 232, 74, 6),
                  //                   size: 40,
                  //                 ),
                  //                 Padding(
                  //                   padding: EdgeInsets.all(10.0),
                  //                   child: Text(
                  //                     'Add songs',
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ),
                  //               ]),
                  //         ),
                  //       ),
                  //     ),

                  //     // themecyan(),
                  //     Positioned(
                  //       top: 20.0,
                  //       left: 20.0,
                  //       right: 0.0,
                  //       bottom: 80.0,
                  //       child: SafeArea(
                  //         child: ValueListenableBuilder(
                  //             valueListenable: dbBox.listenable(),
                  //             builder: (BuildContext context,
                  //                  value, Widget? _) {
                  //               return ListView.separated(
                  //                   itemBuilder: (context, index) {
                  //                     return ListTile(
                  //                         onTap: () async {
                  //                           await play(audioPlayer,
                  //                               finalSongListFavorite);

                  //                           // audioPlayer.open(
                  //                           //   Playlist(
                  //                           //       audios:
                  //                           //           finalSongListFavorite),
                  //                           //   showNotification: true,
                  //                           //   autoStart: false,
                  //                           //   loopMode: LoopMode.playlist,
                  //                           //   playInBackground:PlayInBackground.disabledPause,
                  //                           // );
                  //                           await audioPlayer
                  //                               .playlistPlayAtIndex(index);
                  //                         },
                  //                         onLongPress: () {
                  //                           setState(() {
                  //                             finalSongListFavorite
                  //                                 .removeAt(index);
                  //                             favoriteSongsIdDb.removeAt(index);
                  //                           });
                  //                           // favoriteAudioList();

                  //                           favorites = false;
                  //                         },

                  //                         // playMusic(index: index, assetsAudioplayer: assetAudioPlayer);

                  //                         //   Navigator.of(context).push(MaterialPageRoute(
                  //                         //     builder: (context) {
                  //                         //       return DupeNowPlayingScreen(au
                  //                         //         index: index,
                  //                         //       );
                  //                         //     },
                  //                         //   )

                  //                         //       //     builder: (ctx) =>
                  //                         //       // NOwPlayingScreen(
                  //                         //       //       realtimePlayingInfos: realtimePlayingInfos,
                  //                         //       //       index: index,
                  //                         //       //       assetsAudioPlayer: assetAudioPlayer,
                  //                         //       //     ),
                  //                         //       //   ),
                  //                         //       );

                  //                         leading: CircleAvatar(
                  //                           maxRadius: 30,

                  //                           backgroundImage: AssetImage(
                  //                               'assets/images/music logomp3.jpg'),
                  //                           // backgroundImage: AssetImage(
                  //                           //   widget.allAudios[index].metas.image!.path,
                  //                           // ),

                  //                           //AssetImage(audioList[index].metas.image!.path),
                  //                           child: Container(
                  //                             decoration: BoxDecoration(
                  //                               boxShadow: [
                  //                                 BoxShadow(
                  //                                   color: const Color.fromARGB(
                  //                                           255, 41, 41, 41)
                  //                                       .withOpacity(0.3),
                  //                                   spreadRadius: 8,
                  //                                   blurRadius: 5,
                  //                                   offset: const Offset(0, 0),
                  //                                 ),
                  //                               ],
                  //                               shape: BoxShape.circle,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         title: Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               bottom: 10),
                  //                           child: Text(
                  //                             //realtimePlayingInfos.current!.audio.audio.metas.title!,
                  //                             favoriteSongsList[index].title,

                  //                             style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 overflow:
                  //                                     TextOverflow.ellipsis),
                  //                           ),
                  //                         ),
                  //                         subtitle: Text(
                  //                           favoriteSongsList[index].album,
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               overflow:
                  //                                   TextOverflow.ellipsis),
                  //                         ),
                  //                         trailing: Text(index.toString()));
                  //                   },
                  //                   separatorBuilder:
                  //                       (BuildContext context, int index) {
                  //                     return Padding(
                  //                       padding: EdgeInsets.only(
                  //                           right: 20, top: 10, bottom: 10),
                  //                       child: Column(
                  //                         children: const [
                  //                           Divider(
                  //                             thickness: 2,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     );
                  //                   },
                  //                   itemCount: favoriteSongsList.length);
                  //             }),
                  //       ),

                  //       //  HomeListView(assetsAudioplayer: assetsaudioPlayer,),
                  //     ),

                  //     // Positioned(
                  //     //   top: 40.0,
                  //     //   child: SizedBox(
                  //     //       width: MediaQuery.of(context).size.width * 1,
                  //     //       child: Row(
                  //     //         mainAxisSize: MainAxisSize.max,
                  //     //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     //         children: [
                  //     //           iconBtn(() {}, Icons.refresh_outlined),
                  //     //           iconBtn(() {
                  //     //             // Navigator.of(context).push(MaterialPageRoute(
                  //     //             //     builder: (ctx) => FavoriteScreen(
                  //     //             //           assetaudioPlayer: audioPlayer,
                  //     //             //           audiolist: widget.allAudios,
                  //     //             //         )));
                  //     //           }, Icons.favorite),
                  //     //           iconBtn(() {
                  //     //             // Navigator.of(context)
                  //     //             //     .push(MaterialPageRoute(builder: (ctx) {
                  //     //             //   return PlayListScreen(
                  //     //             //       assetsaudioPlayer: audioPlayer,
                  //     //             //       audioLists: widget.allAudios);
                  //     //             // }));
                  //     //           }, Icons.playlist_add),
                  //     //         ],
                  //     //       )),
                  //     // ),
                  //   ],
                  // ),
                ]))));
  }

//   final playlistNameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   var error = false;

//   void addPlaylistForm(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: const Text('Add new playlist'),
//             content: Form(
//               child: TextFormField(
//                 controller: playlistNameController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(5)))),
//               ),
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('cancel')),
//               TextButton(
//                   onPressed: () async {
//                     if (playlistNameController.text.isEmpty ||
//                         playlistNameController.text == 'favorite') {
//                       SnackBar playlistSnackbar = const SnackBar(
//                         content: Text('Enter a valid name'),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(playlistSnackbar);
//                       Navigator.of(context).pop();
//                       playlistNameController.clear();
//                     } else {
//                       var a = dbBox.values.where((element) =>
//                           element. == playlistNameController.text);
//                       if (a.isEmpty) {
//                         final playlistDataTemp = MusicPlayListNames(
//                             name: playlistNameController.text);
//                         final nId = await playListNamesDb.add(playlistDataTemp);
//                         final playlistData = MusicPlayListNames(
//                             id: nId, name: playlistNameController.text);
//                         playListNamesNotifier.value.add(playlistData);

//                         playListNamesNotifier.notifyListeners();

//                         playlistNameController.clear();
//                         Navigator.of(context).pop();
//                       } else {
//                         SnackBar playlistSnackbar = const SnackBar(
//                           content: Text('playlist name is already exist'),
//                         );
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(playlistSnackbar);
//                         Navigator.of(context).pop();
//                         playlistNameController.clear();
//                       }
//                     }
//                   },
//                   child: const Text('create'))
//             ],
//           );
//         });
//   }
// }

  TextEditingController playListNamesController = TextEditingController();

// void playlistNameEdit(context, index) {
//   playListNamesController.text = playListNamesNotifier.value[index].name;
//   showDialog(
//       context: context,
//       builder: (ctx) {
//         return AlertDialog(
//           title: const Text('Edit playlist '),
//           content: Form(
//             child: TextFormField(
//               controller: playListNamesController,
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(5)))),
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Cancel')),
//             TextButton(
//                 onPressed: () async {
//                   if (playListNamesController.text.isEmpty ||
//                       playListNamesController.text == 'favorite') {
//                     SnackBar playlistSnackbar = const SnackBar(
//                       content: Text('Enter a valid name'),
//                     );
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(playlistSnackbar);
//                     Navigator.of(context).pop();
//                     playListNamesController.clear();
//                   } else {
//                     var a = playListNamesDb.values.where((element) =>
//                         element.name == playListNamesController.text);
//                     if (a.isEmpty) {
//                       final playlistDataTemp = MusicPlayListNames(
//                           name: playListNamesController.text);
//                       await playListNamesDb.put(index, playlistDataTemp);
//                       final playlistsongstempedit = playListSongsDb
//                           .get(playListSongsNotifier.value[index].names);
//                       playlistsongstempedit!.names =
//                           playListNamesController.text;

//                       final playlistData = MusicPlayListNames(
//                           id: index, name: playListNamesController.text);
//                       playListNamesNotifier.value.add(playlistData);

//                       playListNamesNotifier.notifyListeners();

//                       playListNamesController.clear();
//                       Navigator.of(context).pop();
//                     } else {
//                       SnackBar playlistSnackbar = const SnackBar(
//                         content: Text('playlist name is already exist'),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(playlistSnackbar);
//                       Navigator.of(context).pop();
//                       playListNamesController.clear();
//                     }
//                   }
//                 },
//                 child: Text('Ok'))
//           ],
//         );
//       });
// }

  // void favoritebtnAction(index) async {
  //   List result = favoriteSongsIdDb
  //       .where((element) => element == songsFromDb[index].id)
  //       .toList();

  //   if (result.isEmpty) {
  // final favoritedata = MusicFavorites(
  //     id: songsFromDb[index].id,
  //     path: songsFromDb[index].path,
  //     album: songsFromDb[index].album,
  //     title: songsFromDb[index].title,
  //     duration: songsFromDb[index].duration);
  // favoritesDb.add(favoritedata);
  // favoriteListNotifier.value.add(favoritedata);

  // favoriteSongsIdDb.add(songsFromDb[index].id!);
  // box.put('favorites', favoriteSongsIdDb);
  // favoriteSongsIdDb = box.get('favorites') as List<dynamic>;
  // favoriteSongsIdDb.sort(
  //   (b, a) => a.compareTo(b),
  // );

  // favoritesonglistNotifierdb.value.addAll(favoriteSongsIdDb);

  // log(favoriteSongsIdDb.toString());

  // log(favoriteSongsIdDb.toString());

  // log(result.toString());
  //     for (var i = 0; i < favoriteSongsIdDb.length; i++) {
  //   finalSongListFavorite.add(Audio.file(favoriteSongsIdDb[i].path,
  //       metas: Metas(
  //         title: favoriteSongsList[i].title,
  //         artist: favoriteSongsList[i].album,
  //       )));
  // }
  // for (var element in ) {
  //   finalSongListFavorite.add(Audio.file(favoriteSongsIdDb.path));
  // }

  //     favorites = false;
  //   } else {
  //     favorites = true;
  //   }
  // }

  List<int> sortedFavoriteSongList = [];

// void addPlaylistSongsDbNowPlay(
//     index, RealtimePlayingInfos realtimePlayingInfos, context) async {
//   List<MusicPlayListSongs> currentList = playListSongsDb.values.toList();
//   var contains = currentList.where((element) =>
//       element.names == playListNamesNotifier.value[index].name &&
//       element.songs ==
//           musicValueNotifier.value[realtimePlayingInfos.current!.index].path);

//   if (contains.isEmpty) {
//     final listofPlaylistData = MusicPlayListSongs(
//         id: realtimePlayingInfos.current!.index,
//         songs: realtimePlayingInfos.current!.audio.audio.path,
//         names: playListNamesNotifier.value[index].name,
//         title: realtimePlayingInfos.current!.audio.audio.metas.title!,
//         subtitle: realtimePlayingInfos.current!.audio.audio.metas.title!,
//         duration: musicValueNotifier
//             .value[realtimePlayingInfos.current!.index].duration);
//     playListSongsDb.add(listofPlaylistData);

//     log(playListNames.toString());

//     playListSongsNotifier.value.add(listofPlaylistData);
//     playListSongsNotifier.notifyListeners();

//     log(listofPlaylistData.songs.toString());
//     SnackBar playlistSnackbar = SnackBar(
//       content: Text('Song  added to playlist'),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
//     Navigator.of(context).pop();
//   } else {
//     SnackBar playlistSnackbar = SnackBar(
//       content: Text('Song already exist'),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
//     Navigator.of(context).pop();
//   }

//   // final music = playListSongsDb.getAt(playlistNameIndex);
//   // log(music!.songs.toString());
// }

// void favoriteAudioList() {
//   favoriteSongsList = songsFromDb.where((element) {
//     return favoriteSongsIdDb.contains(element.id);
//   }).toList();

//   for (var i = 0; i < favoriteSongsList.length; i++) {
//     finalSongListFavorite.add(Audio.file(favoriteSongsList[i].path,
//         metas: Metas(
//           title: favoriteSongsList[i].title,
//           artist: favoriteSongsList[i].album,
//         )));
//   }
// }
}

class SongsSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(
              context,
              null,
            );
          } else {
            query = ' ';
          }
        },
        icon: const Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          color: Colors.white,
        ),
      ),
      hintColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 38, 231, 238),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          null,
        );
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

// search element
  @override
  Widget buildSuggestions(BuildContext context) {
    final searched = finalSongList
        .toList()
        .where(
          (element) => element.metas.title!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 38, 38),
      body: searched.isEmpty
          ? const Center(
              child: Text(
                "No Search Result !",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 21, 132, 145),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
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
                        onTap: () async {
                          Navigator.pop(context);
                          await play(audioPlayer, searched, index);
                          await audioPlayer.playlistPlayAtIndex(index);
                        },
                        // onTap: (() async {
                        //   Navigator.pop(context);
                        //   await pla(
                        //     fullSongs: searched,
                        //     index: index,
                        //     songId: int.parse(
                        //       searched[index].metas.id!,
                        //     ).toString(),
                        //   ).openAssetPlayer(
                        //     index: index,
                        //     songs: searched,
                        //   );
                        //   // ignore: use_build_context_synchronously
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: ((context) => MusicPlaySceeen(
                        //             allSongs: fullSongs,
                        //             index: index,
                        //             songId: searched.toString(),
                        //           )),
                        //     ),
                        //   );
                        // }),
                        title: Padding(
                          padding: const EdgeInsets.only(
                            left: 5.0,
                            bottom: 3,
                            top: 3,
                          ),
                          child: Text(
                            searched[index].metas.title!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(
                            left: 7.0,
                          ),
                          child: Text(
                            finalSongList[index].metas.artist!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (
                    context,
                    index,
                  ) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: searched.length),
            ),
    );
  }
}
