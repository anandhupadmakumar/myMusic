import 'package:flutter/material.dart';
import 'package:music_sample/screens/home_screen_duplicate.dart';

import '../db_functions/db_crud_function.dart';
import '../db_functions/music_modal_class.dart';
import '../main.dart';
import '../widgets/bottom_sheet_miniplayer.dart';
import '../widgets/bottom_sheet_mp_list.dart';
import '../widgets/theme_color.dart';

List<String> playListSongNames = [];

class MyPlaylistScreen extends StatefulWidget {
  int index;
  MyPlaylistScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<MyPlaylistScreen> createState() => _MyPlaylistScreenState();
}

class _MyPlaylistScreenState extends State<MyPlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    playListSongsNotifier.value.clear();

    playListSongsNotifier.value.addAll(playListSongsDb.values);
    playListSongsNotifier.notifyListeners();

    return Scaffold(
      bottomSheet:BottomSheet(
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
              return bottomMiniPlayer(context:context,audioPlayer: audioPlayer, );
            }),
      backgroundColor: Color.fromARGB(255, 38, 38, 38),
      appBar: AppBar(
        // title: Text(widget.assetsAudioPlayer!.getCurrentAudioTitle),
        title: Text(playListNamesNotifier.value[widget.index].name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                bottomSheetPlaylist(context, widget.index);
              },
              icon: Icon(Icons.add_circle_outline_outlined))
        ],
      ),
      body: Stack(
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
                  valueListenable: playListSongsNotifier,
                  builder: (BuildContext context,
                      List<MusicPlayListSongs> value, Widget? _) {
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          return playListSongsNotifier.value[index].names ==
                                  playListNamesNotifier.value[widget.index].name
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ListTile(
                                      onTap: () {
                                        
                                          // audioPlayer.playlistPlayAtIndex(
                                          //     playListSongsNotifier
                                          //         .value[index].id!);
                                        
                                      
                                      },
                                      onLongPress: () => setState(() {
                                            playListSongsDb.deleteAt(index);
                                          }),
                                      leading: CircleAvatar(
                                        maxRadius: 30,
                                        backgroundImage: AssetImage(
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
                                        child: value[widget.index].songs.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  'No Songs Found',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                //realtimePlayingInfos.current!.audio.audio.metas.title!,
                                                playListSongsNotifier
                                                    .value[index].title,

                                                style: TextStyle(
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                      ),
                                      trailing: Text(playListSongsNotifier
                                          .value[index].duration)),
                                )
                              : const SizedBox();
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
    );
  }
}
