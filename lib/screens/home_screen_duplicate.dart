import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:music_sample/main.dart';
import 'package:music_sample/screens/playlist_add_screen.dart';
import 'package:music_sample/widgets/iconbtn_widget.dart';

import '../db_functions/db_crud_function.dart';
import '../db_functions/music_modal_class.dart';
import '../widgets/bottom_sheet_miniplayer.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/theme_color.dart';
import 'splash_screen.dart';

List<String> playListNames = [];
bool favorites = false;
bool playlistvalidation = false;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

class HomeScreenDupe extends StatefulWidget {
  const HomeScreenDupe({Key? key}) : super(key: key);

  @override
  State<HomeScreenDupe> createState() => _HomeScreenDupeState();
}

class _HomeScreenDupeState extends State<HomeScreenDupe>
    with TickerProviderStateMixin {
  int? _index;
  @override
  void initState() {
    play(audioPlayer);

    // TODO: implement initState
    super.initState();
  }

  Future<void> play(AssetsAudioPlayer assetsaudioPlayer) async {
    // for (var i = 0; i < 3; i++) {
    //   widget.abc.add(Audio.file(
    //     musicValueNotifier.value[0].path![i],
    //   ));
    //   log('inside for loop ................${widget.abc.toString()}');
    // }

    await assetsaudioPlayer.open(
      Playlist(audios: finalSongList),
      showNotification: true,
      autoStart: true,
      loopMode: LoopMode.playlist,
      // notificationSettings: const NotificationSettings(
      //     stopEnabled: false, nextEnabled: true, prevEnabled: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    playListNamesNotifier.value.clear();
    playListNamesNotifier.value.addAll(playListNamesDb.values);
    playListNamesNotifier.notifyListeners();
    favoriteListNotifier.value.clear();
    favoriteListNotifier.value.addAll(favoritesDb.values);
    favoriteListNotifier.notifyListeners();
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
                  context: context, audioPlayer: audioPlayer, index: _index);
            }),
        drawer: MpDrawer(audioPlayer: audioPlayer),
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
                              print(favorites);
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
                              valueListenable: musicValueNotifier,
                              builder: (BuildContext context,
                                  List<MusicModel> value, Widget? _) {
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      bool fav = false;
                                      return ListTile(
                                        onTap: (() {
                                          audioPlayer
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

                                          backgroundImage: AssetImage(
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
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                                  musicValueNotifier
                                                      .value[index].title,

                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    setState(() {
                                                      fav = favorites;
                                                    });

                                                    favoritebtnAction(index);

                                                    favoriteSnackbar(
                                                        context: context);
                                                  });
                                                },
                                                icon: fav == true
                                                    ? Icon(Icons.favorite,
                                                        key: Key(
                                                            'icon key $index'),
                                                        color: Colors.redAccent)
                                                    : Icon(
                                                        Icons.favorite_border),
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              musicValueNotifier
                                                  .value[index].album,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(musicValueNotifier
                                                .value[index].duration)
                                          ],
                                        ),

                                        // trailing: Text(musicValueNotifier
                                        //     .value[index].duration));
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 20, top: 10, bottom: 10),
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      );
                                    },
                                    itemCount: finalSongList.length);
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
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      themeBlue(),
                      themePink(),
                      Positioned(
                        top: 0,
                        child: InkWell(
                          onTap: (() {
                            addPlaylistForm(context);
                          }),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            margin: EdgeInsets.only(left: 40, top: 20),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 14, 14, 14)
                                        .withOpacity(0.1),
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
                                      'Create Playlist',
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
                              valueListenable: playListNamesNotifier,
                              builder: (BuildContext context,
                                  List<MusicPlayListNames> value, Widget? _) {
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  MyPlaylistScreen(
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                        onLongPress: () => setState(() {
                                          playListNamesDb.deleteAt(index);
                                        }),

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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: Material(
                                            elevation: 18.0,
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.asset(
                                                'assets/images/playlist-app-icon-button-260nw-1906619590.png',
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // backgroundImage: AssetImage(
                                        //   widget.allAudios[index].metas.image!.path,
                                        // ),

                                        //AssetImage(audioList[index].metas.image!.path),

                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                            playListNamesNotifier
                                                .value[index].name,

                                            style: const TextStyle(
                                                color: Colors.white,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              playlistNameEdit(context, index);
                                            },
                                            icon: const Icon(Icons.edit)),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
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
                                    itemCount:
                                        playListNamesNotifier.value.length);
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

                  //favorite list
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      themeBlue(),
                      themePink(),

                      // themecyan(),
                      Positioned(
                        top: 20.0,
                        left: 20.0,
                        right: 0.0,
                        bottom: 80.0,
                        child: SafeArea(
                          child: ValueListenableBuilder(
                              valueListenable: favoriteListNotifier,
                              builder: (BuildContext context,
                                  List<MusicFavorites> value, Widget? _) {
                                return ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                          onTap: () {
                                            audioPlayer.playlistPlayAtIndex(
                                                favoriteListNotifier
                                                    .value[index].id!);
                                          },
                                          onLongPress: () => setState(() {
                                                favoritesDb.deleteAt(index);

                                                favorites = false;
                                              }),

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

                                          leading: CircleAvatar(
                                            maxRadius: 30,

                                            backgroundImage: AssetImage(
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
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                              favoriteListNotifier
                                                  .value[index].title,

                                              style: TextStyle(
                                                  color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          trailing: Text(index.toString()));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 20, top: 10, bottom: 10),
                                        child: Column(
                                          children: [
                                            Divider(
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: value.length);
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
                ]))));
  }

  final playlistNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var error = false;

  void addPlaylistForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Add new playlist'),
            content: Form(
              child: TextFormField(
                controller: playlistNameController,
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
                  child: const Text('cancel')),
              TextButton(
                  onPressed: () async {
                    if (playlistNameController.text.isEmpty ||
                        playlistNameController.text == 'favorite') {
                      SnackBar playlistSnackbar = const SnackBar(
                        content: Text('Enter a valid name'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(playlistSnackbar);
                      Navigator.of(context).pop();
                      playlistNameController.clear();
                    } else {
                      var a = playListNamesDb.values.where((element) =>
                          element.name == playlistNameController.text);
                      if (a.isEmpty) {
                        final playlistDataTemp = MusicPlayListNames(
                            name: playlistNameController.text);
                        final nId = await playListNamesDb.add(playlistDataTemp);
                        final playlistData = MusicPlayListNames(
                            id: nId, name: playlistNameController.text);
                        playListNamesNotifier.value.add(playlistData);

                        playListNamesNotifier.notifyListeners();

                        playlistNameController.clear();
                        Navigator.of(context).pop();
                      } else {
                        SnackBar playlistSnackbar = const SnackBar(
                          content: Text('playlist name is already exist'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(playlistSnackbar);
                        Navigator.of(context).pop();
                        playlistNameController.clear();
                      }
                    }
                  },
                  child: const Text('create'))
            ],
          );
        });
  }
}

TextEditingController playListNamesController = TextEditingController();

void playlistNameEdit(context, index) {
  playListNamesController.text = playListNamesNotifier.value[index].name;
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Edit playlist '),
          content: Form(
            child: TextFormField(
              controller: playListNamesController,
              decoration: InputDecoration(
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
                    var a = playListNamesDb.values.where((element) =>
                        element.name == playListNamesController.text);
                    if (a.isEmpty) {
                      final playlistDataTemp = MusicPlayListNames(
                          name: playListNamesController.text);
                      await playListNamesDb.put(index, playlistDataTemp);
                      final playlistsongstempedit = playListSongsDb
                          .get(playListSongsNotifier.value[index].names);
                      playlistsongstempedit!.names =
                          playListNamesController.text;
                      

                      final playlistData = MusicPlayListNames(
                          id: index, name: playListNamesController.text);
                      playListNamesNotifier.value.add(playlistData);

                      playListNamesNotifier.notifyListeners();

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
    favorites = true;
  }
  ScaffoldMessenger.of(context).showSnackBar(showsnackbar);
}

void favoritebtnAction(index) {
  List<MusicFavorites> result = favoriteListNotifier.value
      .where(
          (checking) => checking.path == musicValueNotifier.value[index].path)
      .toList();
  if (result.isEmpty) {
    final favoritedata = MusicFavorites(
        id: index,
        path: musicValueNotifier.value[index].path,
        album: musicValueNotifier.value[index].album,
        title: musicValueNotifier.value[index].title,
        duration: musicValueNotifier.value[index].duration);
    favoritesDb.add(favoritedata);
    favoriteListNotifier.value.add(favoritedata);

    favoriteListNotifier.notifyListeners();

    log(result.toString());
  } else {
    favorites = true;
  }
}

void addPlaylistSongsDbNowPlay(
    index, RealtimePlayingInfos realtimePlayingInfos, context) async {
  List<MusicPlayListSongs> currentList = playListSongsDb.values.toList();
  var contains = currentList.where((element) =>
      element.names == playListNamesNotifier.value[index].name &&
      element.songs ==
          musicValueNotifier.value[realtimePlayingInfos.current!.index].path);

  if (contains.isEmpty) {
    final listofPlaylistData = MusicPlayListSongs(
        id: realtimePlayingInfos.current!.index,
        songs: realtimePlayingInfos.current!.audio.audio.path,
        names: playListNamesNotifier.value[index].name,
        title: realtimePlayingInfos.current!.audio.audio.metas.title!,
        subtitle: realtimePlayingInfos.current!.audio.audio.metas.title!,
        duration: musicValueNotifier
            .value[realtimePlayingInfos.current!.index].duration);
    playListSongsDb.add(listofPlaylistData);

    log(playListNames.toString());

    playListSongsNotifier.value.add(listofPlaylistData);
    playListSongsNotifier.notifyListeners();

    log(listofPlaylistData.songs.toString());
    SnackBar playlistSnackbar = SnackBar(
      content: Text('Song  added to playlist'),
    );
    ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
    Navigator.of(context).pop();
  } else {
    SnackBar playlistSnackbar = SnackBar(
      content: Text('Song already exist'),
    );
    ScaffoldMessenger.of(context).showSnackBar(playlistSnackbar);
    Navigator.of(context).pop();
  }

  // final music = playListSongsDb.getAt(playlistNameIndex);
  // log(music!.songs.toString());
}
