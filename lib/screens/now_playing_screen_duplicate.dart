import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';

import 'package:music_sample/widgets/bottom_sheet_miniplayer.dart';

import '../widgets/iconbtn_widget.dart';
import '../widgets/realtimeinfo_slider.dart';
import '../widgets/theme_color.dart';
import '../widgets/timetext_slider.dart';

class DupeNowPlayingScreen extends StatefulWidget {
  final index;
  AssetsAudioPlayer audioPlayer;
  DupeNowPlayingScreen({Key? key, this.index, required this.audioPlayer})
      : super(key: key);

  @override
  State<DupeNowPlayingScreen> createState() => _DupeNowPlayingScreenState();
}

class _DupeNowPlayingScreenState extends State<DupeNowPlayingScreen> {
  // AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // play(widget.audioPlayer);
  // }

  // void setupPlaylist() async {
  //   await widget.audioPlayer.open(Playlist(audios: audioList),
  //       showNotification: true, autoStart: false, loopMode: LoopMode.playlist);
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   widget.audioPlayer.dispose();
  // }

  Widget audioImage(RealtimePlayingInfos realtimePlayingInfos) {
    // return Container(
    //   height: MediaQuery.of(context).size.height * 0.45,
    //   width: MediaQuery.of(context).size.width * 0.85,
    //   child: Material(
    //     elevation: 18.0,
    //     color: Colors.transparent,
    //     borderRadius: BorderRadius.circular(50.0),
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(50.0),
    //       // child: Image.asset(
    //       //   realtimePlayingInfos.current!.audio.audio.metas.image!.path,
    //       //   fit: BoxFit.cover,
    //       //   filterQuality: FilterQuality.high,
    //       // ),
    //     ),
    //   ),
    // );
    return CircleAvatar(
      radius: 120,
      backgroundColor: Color.fromARGB(0, 48, 207, 228),
      backgroundImage:
          // AssetImage(widget.realtimePlayingInfos
          //     .current!.audio.audio.metas.image!.path)
          AssetImage(
        'assets/images/now_playing-mp3.png',
      ),
    );
  }

  Widget playlistFavButtons(RealtimePlayingInfos realtimePlayingInfos) {
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
              velocity: realtimePlayingInfos.duration.inMinutes.toDouble(),
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
        ],
      ),
    );
  }

  Widget title(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textMoving(
            realtimePlayingInfos, context)
      ],
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
          icon: Icon(Icons.compare_arrows_rounded),
          iconSize: 30,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          onPressed: () => widget.audioPlayer.previous(),
          icon: Icon(Icons.fast_rewind_rounded),
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
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.assetsAudioPlayer!.getCurrentAudioTitle),
        title: Text('Now Playing'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 48, 48, 48),
      body: widget.audioPlayer.builderRealtimePlayingInfos(
          builder: ((context, realtimePlayingInfos) {
        if (realtimePlayingInfos != null) {
          return Stack(
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
                    SizedBox(
                      height: 40,
                    ),
                    audioImage(realtimePlayingInfos),
                    SizedBox(
                      height: 50,
                    ),
                    playlistFavButtons(realtimePlayingInfos),
                    SizedBox(
                      height: 10,
                    ),
                    title(realtimePlayingInfos),
                    SizedBox(
                      height: 10,
                    ),
                    slider(realtimePlayingInfos),
                    tmeStamp(realtimePlayingInfos),
                     SizedBox(
                      height: 10,
                    ),
                    playBar(realtimePlayingInfos),
                  ],
                ),
              )
            ],
          );
        } else {
          return Column();
        }
      })),
    );
  }
}
