import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_sample/db_functions/db_crud_function.dart';
import 'package:music_sample/screens/home_screen.dart';
import 'package:music_sample/screens/splash_screen.dart';

import 'package:music_sample/widgets/bottom_sheet_miniplayer.dart';

import 'package:music_sample/widgets/iconbtn_widget.dart';
import 'package:music_sample/widgets/navigation_drawer.dart';
import 'package:music_sample/widgets/theme_color.dart';

import '../db_functions/music_modal_class.dart';
import 'home_screen.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  static int _index = 0;

  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  var musicListData;

  @override
  void initState() {
   
    setState(() {
      play(audioPlayer);
    });

    // TODO: implement initState
    super.initState();
  }

  Future<void> play(AssetsAudioPlayer assetsaudioPlayer) async {
    log('..........................!!!!!!!!!${HomeScreen._index}');

    // for (var i = 0; i < 3; i++) {
    //   widget.abc.add(Audio.file(
    //     musicValueNotifier.value[0].path![i],
    //   ));
    //   log('inside for loop ................${widget.abc.toString()}');
    // }

   

    await assetsaudioPlayer.open(
      Playlist(audios: finalSongList),
      showNotification: false,
      autoStart: false,
      loopMode: LoopMode.playlist,
      notificationSettings: const NotificationSettings(
          stopEnabled: false, nextEnabled: true, prevEnabled: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qWidth = MediaQuery.of(context).size.width;
    final qHeight = MediaQuery.of(context).size.height;
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
              return bottomMiniPlayer(context, audioPlayer);
            }),
        drawer: MpDrawer(audioPlayer: audioPlayer),
        backgroundColor: const Color.fromARGB(255, 44, 43, 43),
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text('MUSIC'),
                centerTitle: true,
                background: Image.asset(
                  'assets/images/dj.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              pinned: true,
              floating: true,
              expandedHeight: 150,
              //title: const Text('Music'),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: qWidth,
                height: qHeight,
                child: SafeArea(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      themeBlue(),
                      themePink(),
                      // themecyan(),
                      Positioned(
                        top: 120.0,
                        left: 20.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: SafeArea(
                          child: ValueListenableBuilder(
                              valueListenable: musicValueNotifier,
                              builder: (BuildContext context,
                                  List<MusicModel> value, Widget? _) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          // if (audioPlayer.current.value !=
                                          //     null) {
                                          //   audioPlayer.stop();
                                          // }

                                          audioPlayer
                                              .playlistPlayAtIndex(index);

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
                                        },
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
                                        title: Text(
                                          //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                          finalSongList[index].metas.title!,

                                          style: TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        subtitle:  Text(
                                          finalSongList[index].metas.album!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              //search song
                                            },
                                            icon: const Icon(
                                                Icons.more_vert_outlined)),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Padding(
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
                      Positioned(
                        top: 40.0,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                iconBtn(() {}, Icons.refresh_outlined),
                                iconBtn(() {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (ctx) => FavoriteScreen(
                                  //           assetaudioPlayer: audioPlayer,
                                  //           audiolist: widget.allAudios,
                                  //         )));
                                }, Icons.favorite),
                                iconBtn(() {
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (ctx) {
                                  //   return PlayListScreen(
                                  //       assetsaudioPlayer: audioPlayer,
                                  //       audioLists: widget.allAudios);
                                  // }));
                                }, Icons.playlist_add),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  // Widget realtimeHomeListview(AssetsAudioPlayer assetsAudioPlayer) {
  //   return
  // }
  @override
  void dispose() {
    bool _isDisposed = false;
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    _isDisposed = true;
  }
}
