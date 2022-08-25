// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:marquee/marquee.dart';
import 'package:music_sample/db_functions/db_crud_function.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';
import 'package:music_sample/main.dart';
import 'package:music_sample/screens/playlist_name_screen.dart';
import 'package:music_sample/screens/splash_screen.dart';

import 'package:music_sample/widgets/bottom_sheet_miniplayer.dart';

import '../widgets/bottom_sheet_mp_list.dart';
import '../widgets/iconbtn_widget.dart';
import '../widgets/realtimeinfo_slider.dart';
import '../widgets/theme_color.dart';
import '../widgets/timetext_slider.dart';
import 'home_screen_duplicate.dart';

class DupeNowPlayingScreen extends StatefulWidget {
  final index;
  AssetsAudioPlayer audioPlayer;
  DupeNowPlayingScreen({Key? key, this.index, required this.audioPlayer})
      : super(key: key);

  @override
  State<DupeNowPlayingScreen> createState() => _DupeNowPlayingScreenState();
}

class _DupeNowPlayingScreenState extends State<DupeNowPlayingScreen> {
  bool playingLoop = false;

  
  Widget audioImage(RealtimePlayingInfos realtimePlayingInfos) {
    return const Padding(
      padding:  EdgeInsets.only(top: 40),
      child:  CircleAvatar(
        radius: 120,
        backgroundColor: Color.fromARGB(0, 48, 207, 228),
        backgroundImage:
            // AssetImage(realtimePlayingInfos
            //     .current!.audio.audio.metas.image!.path)
            AssetImage(
          'assets/images/now_playing-mp3.png',
        ),
      ),
    );
  }

  Future<void> nowPlayerBottomSheetPlaylist(
      RealtimePlayingInfos realtimePlayingInfos) async {
    showModalBottomSheet(
        backgroundColor: const Color.fromARGB(255, 33, 81, 88),
        // isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        context: context,
        builder: (ctx) {
          return SafeArea(
            child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (BuildContext context, value, Widget? _) {
                  playlistNames = box.get('playlist_name') as List<dynamic>;
                  print(playlistNames);
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            playlistSongIdAdd(
                                index,
                                songsFromDb[realtimePlayingInfos.current!.index]
                                    .id,
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

  Widget playlistFavButtons(RealtimePlayingInfos realtimePlayingInfos) {
    bool favColor = false;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Marquee(
              text: realtimePlayingInfos.current!.audio.audio.metas.title!,
              pauseAfterRound: Duration(seconds: 0),
              velocity: 5,
              style: TextStyle(color: Colors.white, fontSize: 20),
              blankSpace: 30,
              crossAxisAlignment: CrossAxisAlignment.start,
              // text: realtimePlayingInfos.current!.audio.audio.metas.title!,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // favoritebtnAction(realtimePlayingInfos.current!.index);
                  // favoriteSnackbar(context: context);
                  setState(() {
                    if (favoriteIdList.contains(
                        songsFromDb[realtimePlayingInfos.current!.index].id)) {
                      favoriteIdList.remove(
                          songsFromDb[realtimePlayingInfos.current!.index].id);
                      box.put('favourites', favoriteIdList);
                    } else {
                      favoriteIdAdd(
                          songsFromDb[realtimePlayingInfos.current!.index].id!,
                          realtimePlayingInfos.current!.index);
                    }
                  });

                  // add to user's favorite list
                  //show snack bar when selected the favorite icon
                },
                icon: Icon(
                  Icons.favorite,
                  color: favoriteIdList.contains(
                          songsFromDb[realtimePlayingInfos.current!.index].id)
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
              iconBtn(() {
                //open play list and add user selected list
                nowPlayerBottomSheetPlaylist(realtimePlayingInfos);
              }, Icons.playlist_add),
              iconBtn(() {
                Navigator.of(context).pop();
              }, Icons.exit_to_app)
            ],
          ),
        ],
      ),
    );
  }

  Widget title(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [textMoving(realtimePlayingInfos, context)],
    );
  }

  Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
    return SliderTheme(
        data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.8),
            trackShape: Customshape()),
        child: Slider.adaptive(
            autofocus: true,
            value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
            max: realtimePlayingInfos.duration.inSeconds.toDouble() + 1,
            onChanged: (value) {
              widget.audioPlayer.seek(Duration(seconds: value.toInt()));
            }));

    // return Slider.adaptive(
    //     value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
    //     max: realtimePlayingInfos.duration.inSeconds.toDouble(),
    //     onChanged: (value) {
    //       widget.audioPlayer.seek(Duration(seconds: value.toInt()));
    //     });
  }

  Widget tmeStamp(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(transformString(realtimePlayingInfos.currentPosition.inSeconds)),
        Text(
          transformString(realtimePlayingInfos.duration.inSeconds),
        ),
      ],
    );
  }

  Widget playBar(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            if (!playingLoop) {
              audioPlayer.setLoopMode(LoopMode.single);
              setState(() {
                playingLoop = true;
              });
            } else {
              audioPlayer.setLoopMode(LoopMode.playlist);
              setState(() {
                playingLoop = false;
              });
            }
          },
          icon: playingLoop ? Icon(Icons.repeat_one) : Icon(Icons.repeat),
          iconSize: 30,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          onPressed: () => widget.audioPlayer.previous(),
          icon: const Icon(Icons.fast_rewind_rounded),
          iconSize: 30,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          onPressed: () {
            widget.audioPlayer.playOrPause();
          },
          icon: Icon(realtimePlayingInfos.isPlaying
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded),
          iconSize: 70,
          color: Color.fromARGB(255, 5, 237, 237),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          onPressed: () => widget.audioPlayer.next(),
          icon: Icon(Icons.fast_forward_rounded),
          iconSize: 30,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          onPressed: () {
            playlistNowPlayingScreen(context);
          },
          icon: Icon(Icons.playlist_play),
          iconSize: 30,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.assetsAudioPlayer!.getCurrentAudioTitle),
        title: const Text('Now Playing'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      body: widget.audioPlayer.builderRealtimePlayingInfos(
          builder: ((context, realtimePlayingInfos) {
        if (realtimePlayingInfos != null) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 48, 48, 48),
            body: SizedBox(
              child: Stack(
                children: [
                  themeBlue(),
                  themePink(),
                  Positioned(
                    left: 20,
                    top: 0,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(
                        //   height: 40,
                        // ),
                        audioImage(realtimePlayingInfos),
                        const SizedBox(
                          height: 50,
                        ),
                        playlistFavButtons(realtimePlayingInfos),
                        const SizedBox(
                          height: 10,
                        ),
                        title(realtimePlayingInfos),
                        const SizedBox(
                          height: 10,
                        ),
                        slider(realtimePlayingInfos),
                        tmeStamp(realtimePlayingInfos),
                        const SizedBox(
                          height: 10,
                        ),
                        playBar(realtimePlayingInfos),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Column();
        }
      })),
    );
  }
}

playlistNowPlayingScreen(context) {
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
              builder: (BuildContext context, songlist, Widget? _) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: (() async {
                          await play(audioPlayer, finalSongList, index);
                          await audioPlayer.playlistPlayAtIndex(index);
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

                          backgroundImage:
                              AssetImage('assets/images/music logomp3.jpg'),
                          // backgroundImage: AssetImage(
                          //   widget.allAudios[index].metas.image!.path,
                          // ),

                          //AssetImage(audioList[index].metas.image!.path),
                          child: Container(
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
                                width: 200,
                                child: Text(
                                  //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                  songsFromDb[index].title!,

                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                songsFromDb[index].album!,

                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Text(songsFromDb[index].duration)
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

  //  HomeListView(assetsAudioplayer: assetsaudioPlayer,),
}
