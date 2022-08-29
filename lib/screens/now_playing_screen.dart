// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';




import 'package:heza/widgets/iconbtn_widget.dart';
import 'package:heza/widgets/theme_color.dart';



import '../widgets/timetext_slider.dart';

class NOwPlayingScreen extends StatefulWidget {
  var index;
  var image;
  AssetsAudioPlayer? assetsAudioPlayer;
  RealtimePlayingInfos realtimePlayingInfos;

  NOwPlayingScreen(
      {Key? key,
      this.index,
      this.assetsAudioPlayer,
      required this.realtimePlayingInfos})
      : super(key: key);

  @override
  State<NOwPlayingScreen> createState() => _NOwPlayingScreenState();
}

class _NOwPlayingScreenState extends State<NOwPlayingScreen> {
  var _value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  // double _value = 0.0; //seek
  // bool playing = true;
  // IconData playIcon = Icons.pause;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.assetsAudioPlayer!.getCurrentAudioTitle),
        title:
            Text(widget.realtimePlayingInfos.current!.audio.audio.metas.title!),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            themeBlue(),
            themePink(),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.12,
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Color.fromARGB(0, 48, 207, 228),
                backgroundImage:
                    // AssetImage(widget.realtimePlayingInfos
                    //     .current!.audio.audio.metas.image!.path)
                    AssetImage(widget.realtimePlayingInfos.current!.audio.audio
                        .metas.image!.path),
              ),
            ),
            Positioned(
                top: 350,
                width: MediaQuery.of(context).size.width,
                // top: MediaQuery.of(context).size.width * 0.1,
                // left: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconBtn(() {
                            // add to user's favorite list
                            //show snack bar when selected the favorite icon
                          }, Icons.favorite),
                          iconBtn(() {
                            //open play list and add user selected list
                          }, Icons.playlist_add),
                          iconBtn(() {
                            Navigator.of(context).pop();
                          }, Icons.exit_to_app)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      // child: realslider(
                      //     widget.realtimePlayingInfos,
                      //   widget.assetsAudioPlayer!),

                      child: Slider(
                        max: widget.realtimePlayingInfos.duration.inSeconds
                            .toDouble(),
                        value: widget
                            .realtimePlayingInfos.currentPosition.inSeconds
                            .toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            widget.assetsAudioPlayer!
                                .seek(Duration(seconds: value.toInt()));
                            //forward and backward
                          });
                        },
                      ),
                    ),

                    //ProgressBar(
                    //   progress: Duration(milliseconds: 1000),
                    //   buffered: Duration(milliseconds: 2000),
                    //   total: Duration(milliseconds: 5000),
                    //   onSeek: (duration) {
                    //     print('User selected a new time: $duration');
                    //   },
                    // ),
                    // ),

                    tmeStamp(widget.realtimePlayingInfos),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: const [
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //         left: 40,
                    //       ),
                    //       child: Text('00:00'),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(right: 40),
                    //       child: Text('00:00'),
                    //     )
                    //   ],
                    // ),
                    const SizedBox(
                      height: 40,
                    ),

                   
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     iconBtn(() {
                    //       //restart current music
                    //     }, Icons.restart_alt),
                    //     iconBtn(() {
                    //       setState(() {
                    //         previous(
                    //             assetsAudioPlayer: widget.assetsAudioPlayer!);
                    //         if (widget.index < audioList.length &&
                    //             widget.index > 0) {
                    //           widget.index--;
                    //         } else {
                    //           widget.index = 0;
                    //         }
                    //       });
                    //     }, Icons.skip_previous),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           if (!playing) {
                    //             playMusic(
                    //                 index: widget.index,
                    //                 assetsAudioplayer:
                    //                     widget.assetsAudioPlayer!);
                    //             playing = true;

                    //             playIcon = Icons.pause;
                    //           } else if (widget.assetsAudioPlayer != null) {
                    //             widget.assetsAudioPlayer!.pause();
                    //             //play music code
                    //             playIcon = Icons.play_arrow;
                    //             playing = false;
                    //           }
                    //         });
                    //       },
                    //       child: CircleAvatar(
                    //         radius: 30,
                    //         backgroundColor: Color.fromARGB(239, 7, 224, 239),
                    //         child: Icon(
                    //           playIcon,
                    //           color: Colors.white,
                    //           size: 50,
                    //         ),
                    //       ),
                    //     ),
                    //     iconBtn(() {
                    //       setState(() {
                    //         next(assetsAudioplayer: widget.assetsAudioPlayer!);

                    //         if (widget.index < audioList.length - 1) {
                    //           widget.index++;
                    //         } else {
                    //           widget.index = 0;
                    //         }
                    //       });

                    //       //play next song
                    //     }, Icons.skip_next),
                    //     Builder(builder: (context) {
                    //       return IconButton(
                    //           onPressed: () {
                    //             //current playing list
                    //             setState(() {
                    //               bottomSheet(context);
                    //             });
                    //           },
                    //           icon: Icon(
                    //             Icons.queue_music,
                    //             color: Colors.white,
                    //           ));
                    //     })
                    //   ],
                    // ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // void AnimateIcon(index) {
  //   setState(() {
  //     playing = !playing;

  //     if (!playing) {
  //       assetsAudioPlayer.playlistPlayAtIndex(index);
  //       AnimateIcon(widget.index);
  //       playIcon = Icons.pause;
  //       playing = true;
  //     } else {
  //       //play music code
  //       playIcon = Icons.play_arrow;
  //       playing = false;
  //       assetsAudioPlayer.pause();
  //     }

  //   });
  // }
}
