// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';
import 'package:music_sample/db_functions/db_crud_function.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';
import 'package:music_sample/main.dart';

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
  @override
  Widget audioImage(RealtimePlayingInfos realtimePlayingInfos) {
    return const CircleAvatar(
      radius: 120,
      backgroundColor: Color.fromARGB(0, 48, 207, 228),
      backgroundImage:
          // AssetImage(realtimePlayingInfos
          //     .current!.audio.audio.metas.image!.path)
          AssetImage(
        'assets/images/now_playing-mp3.png',
      ),
    );
  }

  Future<void> nowPlayerBottomSheetPlaylist(
      RealtimePlayingInfos realtimePlayingInfos) async {
    showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 33, 81, 88),
        // isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        context: context,
        builder: (ctx) {
          return SafeArea(
            child: ValueListenableBuilder(
                valueListenable: playListNamesNotifier,
                builder: (BuildContext context, List<MusicPlayListNames> value,
                    Widget? _) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                              onTap: () {
                                addPlaylistSongsDbNowPlay(
                                    index, realtimePlayingInfos, context);
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
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

                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                  playListNamesNotifier.value[index].name,

                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              trailing: Text(index.toString()));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(right: 20, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 2,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: playListNamesNotifier.value.length),
                  );
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
                  favoritebtnAction(realtimePlayingInfos.current!.index);
                  favoriteSnackbar(context: context);
                  setState(() {
                    favColor = favorites;
                  });

                  // add to user's favorite list
                  //show snack bar when selected the favorite icon
                },
                icon: Icon(
                  Icons.favorite,
                  color: favColor == true ? Colors.red : Colors.grey,
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
            max: realtimePlayingInfos.duration.inSeconds.toDouble(),
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
          onPressed: () {},
          icon: const Icon(Icons.compare_arrows_rounded),
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
          onPressed: () {},
          icon: Icon(Icons.autorenew_rounded),
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
                        const SizedBox(
                          height: 40,
                        ),
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
