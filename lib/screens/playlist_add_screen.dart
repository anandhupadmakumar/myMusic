import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_sample/screens/home_screen_duplicate.dart';
import 'package:music_sample/screens/splash_screen.dart';

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
    final playListNames = box.get('playlist_name');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 38, 38),
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
      appBar: AppBar(
        // title: Text(widget.assetsAudioPlayer!.getCurrentAudioTitle),
        title: Text(playListNames![widget.index]),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                playlistAudiolist(key: playListNames[widget.index]);
                bottomSheetPlaylist(
                    context, widget.index, playListNames[widget.index]);
              },
              icon: const Icon(Icons.add_circle_outline_outlined))
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
                  valueListenable: box.listenable(),
                  builder: (BuildContext context, value, Widget? _) {
                    finalSongListPlaylist =
                        playlistAudiolist(key: playListNames[widget.index]);

                    final playlistSongIdList =
                        box.get(playListNames[widget.index]);

                    return playlistSongIdList == null
                        ? const Center(
                            child: Text('No songs found'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListTile(
                                    onTap: () async {
                                     
                                      await play(audioPlayer,
                                          playlistAudioSongs, index);
                                      await audioPlayer
                                          .playlistPlayAtIndex(index);
                                    },
                                    onLongPress: () => 
                                          deletePopupPlaylistSongs(
                                              context, index, widget.index)
                                        ,
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
                                        finalSongListPlaylist[index].title!,
                                        //realtimePlayingInfos.current!.audio.audio.metas.title!,

                                        style: const TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (favoriteIdList.contains(
                                              songsFromDb[index].id)) {
                                            favoriteIdList
                                                .remove(songsFromDb[index].id);
                                          } else {
                                            favoriteIdAdd(
                                                songsFromDb[index].id!, index);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.favorite,
                                          color: favoriteIdList.contains(
                                                  playlistSongIdList[index])
                                              ? Colors.red
                                              : Colors.grey),
                                    )),
                              );
                            },
                            itemCount: playlistSongIdList.length);
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
                  children: [],
                )),
          ),
        ],
      ),
    );
  }
}
