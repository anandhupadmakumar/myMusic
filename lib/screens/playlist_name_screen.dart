import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';

import '../db_functions/db_crud_function.dart';
import '../main.dart';
import '../widgets/theme_color.dart';
import 'playlist_add_screen.dart';

List<dynamic> playlistNames = [];

class PlayListNameScreen extends StatefulWidget {
  const PlayListNameScreen({Key? key}) : super(key: key);

  @override
  State<PlayListNameScreen> createState() => _PlayListNameScreenState();
}

class _PlayListNameScreenState extends State<PlayListNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      color: Color.fromARGB(255, 14, 14, 14).withOpacity(0.1),
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
                valueListenable: box.listenable(),
                builder: (BuildContext context, value, Widget? _) {
                  playlistNames = box.get('playlist_name') as List<dynamic>;

                  print(playlistNames);
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => MyPlaylistScreen(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          onLongPress: () => setState(() {
                            // final playlistsongid =
                            //     box.get(playlistNames[index]);

                            // playlistsongid!.clear();

                            deletePopupPlaylistName(context,index);
                            //playlist names deleting fun
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
                                playlistNameEdit(
                                    context, index, playlistNames[index]);
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
    );
  }

  final playListNameController = TextEditingController();

  void addPlaylistForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Add new playlist'),
            content: Form(
              child: TextFormField(
                controller: playListNameController,
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
                    if (playListNameController.text.isEmpty ||
                        playListNameController.text == 'favorite') {
                      SnackBar playlistSnackbar = const SnackBar(
                        content: Text('Enter a valid name'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(playlistSnackbar);
                      Navigator.of(context).pop();
                      playListNameController.clear();
                    } else {
                      if (!playlistNames
                          .contains(playListNameController.text)) {
                        playlistNames.add(playListNameController.text);
                        box.put('playlist_name', playlistNames);
                        print(playlistNames);
                        Navigator.of(context).pop();
                        playListNameController.clear();
                      } else {
                        SnackBar playlistSnackbar = const SnackBar(
                          content: Text('playlist name is already exist'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(playlistSnackbar);
                        Navigator.of(context).pop();
                        playListNameController.clear();
                        print(playlistNames);
                      }
                    }
                  },
                  child: const Text('create'))
            ],
          );
        });
  }
}
