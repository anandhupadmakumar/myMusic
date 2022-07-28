import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../widgets/theme_color.dart';
import 'favorite_screen.dart';

class PlayListScreen extends StatelessWidget {
  final AssetsAudioPlayer assetsaudioPlayer;
  List<String> audioLists;

  PlayListScreen(
      {Key? key, required this.assetsaudioPlayer, required this.audioLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 51, 50, 48),
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      //add to playlist
                    },
                    icon: const Icon(Icons.add_circle_outline_sharp)),
              ],
              // expandedHeight: 100,
              snap: true,
              floating: true,
              pinned: true,
              title: Text('LISTS'),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(235, 4, 86, 108),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    themeBlue(),
                    themePink(),
                    Positioned(
                      top: 0.0,
                      left: 20.0,
                      right: 20.0,
                      bottom: 0.0,
                      child: GridView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 3 / 3,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 3, 209, 246),
                                    // Colors.yellow,
                                    Color.fromARGB(255, 67, 65, 65),
                                    Colors.purple
                                  ]),
                                  shape: BoxShape.circle),
                              child: Padding(
                                //this padding will be you border size
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle),
                                  child: Stack(children: [
                                    Positioned(
                                      child: InkWell(
                                        onLongPress: () {
                                          // delete the plalylist with popup
                                          print('playlist delete');
                                        },
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      FavoriteScreen(
                                                        assetaudioPlayer:
                                                            assetsaudioPlayer,audiolist: audioLists,
                                                      )));
                                        },
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundColor: const Color.fromARGB(
                                              0, 48, 207, 228),
                                          backgroundImage: const AssetImage(
                                              'assets/images/dj.jpg'),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Text(
                                                'Favorite',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   top: 60,
                                    //   left: 15,
                                    //   child: Container(
                                    //     child: Row(
                                    //       children: [
                                    //         Icon(
                                    //           Icons.favorite,
                                    //           color: Colors.red,
                                    //           size: 20,
                                    //         ),
                                    //         Text(
                                    //           'Favorite',
                                    //           style: TextStyle(
                                    //               fontSize: 25,
                                    //               fontWeight: FontWeight.bold,
                                    //               color: Colors.white),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ]),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
