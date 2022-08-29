

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:hive_flutter/adapters.dart';
import 'package:heza/main.dart';

import 'package:heza/screens/playlist_name_screen.dart';


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
Future<void> play(
    {required AssetsAudioPlayer assetsaudioPlayer,
    required List<Audio> audioSongs,
    int? index}) async {
  await assetsaudioPlayer.open(
    Playlist(audios: audioSongs, startIndex: index!),
    showNotification:
        notification == null || notification == true ? true : false,
    autoStart: false,
    loopMode: LoopMode.playlist,
    respectSilentMode: false,
    playInBackground: PlayInBackground.disabledPause,
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
                      expandedHeight: 150.h,
                      title: const Text('HEZA '),
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
                                          if (songsSkip) {
                                            songsSkip = false;

                                            await play(
                                                assetsaudioPlayer: audioPlayer,
                                                audioSongs: finalSongList,
                                                index: index);

                                            await audioPlayer
                                                .playlistPlayAtIndex(index);
                                            songsSkip = true;
                                          }
                                        }),
                                       
                                        leading: CircleAvatar(
                                          maxRadius: 30.r,

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
                                              width: 100.w,
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
                                              width: 100.w,
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

                      
                    ],
                  ),
                 

                  PlayListNameScreen(),
                  FavoriteScreen(),

                  
                ]))));
  }


  TextEditingController playListNamesController = TextEditingController();

//  

  List<int> sortedFavoriteSongList = [];

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
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30.r,

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
                          await play(
                              assetsaudioPlayer: audioPlayer,
                              audioSongs: searched,
                              index: index);
                          await audioPlayer.playlistPlayAtIndex(index);
                        },
                        
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
                              fontSize: 18.sp,
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
                      height: 10.h,
                    );
                  },
                  itemCount: searched.length),
            ),
    );
  }
}
