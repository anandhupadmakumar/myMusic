// import 'dart:io';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';

// import 'package:music_sample/screens/now_playing_screen.dart';

// import '../play_operations/play_pause.dart';

// class HomeListView extends StatefulWidget {
//   final assetsAudioplayer;
//   const HomeListView({Key? key, this.assetsAudioplayer}) : super(key: key);

//   @override
//   State<HomeListView> createState() => _HomeListViewState();
// }

// class _HomeListViewState extends State<HomeListView> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {
//               setState(() {
//                 bool playings = false;
//                 playMusic(
//                     index: index, assetsAudioplayer: widget.assetsAudioplayer);
//               });

//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (ctx) => NOwPlayingScreen(
//                     index: index,
//                     assetsAudioPlayer: widget.assetsAudioplayer,
//                     realtimePlayingInfos: widge,
//                   ),
//                 ),
//               );
//             },
//             leading: CircleAvatar(
//               maxRadius: 30,
//               backgroundImage: AssetImage(audioList[index].metas.image!.path),
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color.fromARGB(255, 41, 41, 41)
//                           .withOpacity(0.3),
//                       spreadRadius: 8,
//                       blurRadius: 5,
//                       offset: const Offset(0, 0),
//                     ),
//                   ],
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             title: Text(
//               audioList[index].metas.title.toString(),
//               style: TextStyle(color: Colors.white),
//             ),
//             subtitle: const Text(
//               'sample',
//               style: TextStyle(color: Colors.white),
//             ),
//             trailing: IconButton(
//                 onPressed: () {
//                   //search song
//                 },
//                 icon: const Icon(Icons.more_vert_outlined)),
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return const Padding(
//             padding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
//             child: Divider(
//               thickness: 2,
//             ),
//           );
//         },
//         itemCount: audioList.length);
//   }
// }

// List<Audio> audioList = [
//   Audio(
//     'assets/songs/Alan_Walker_-_Faded(256k).mp3',
//     metas: Metas(
//       title: 'alenwalker',
//       artist: 'anandhu',
//       image: MetasImage.asset('assets/images/dj.jpg'),
//     ),
//   ),
//   Audio(
//     'assets/songs/Arabic_Kuthu_-_Video_Song___Beast___Thalapathy_Vijay___Pooja_Hegde___Sun_Pictures___Nelson___Anirudh(256k).mp3',
//     metas: Metas(
//       title: 'Arabic_Kuthu_Song___Beast___Thalapathy_Vijay',
//       artist: 'anandhu',
//       image: MetasImage.asset('assets/images/vijay.jpg'),
//     ),
//   ),
//   Audio(
//     'assets/songs/Alan_Walker_-_Faded(256k).mp3',
//     metas: Metas(
//       title: 'alenwalker',
//       artist: 'anandhu',
//       image: MetasImage.asset('assets/images/favorites.jpg'),
//     ),
//   ),
//   Audio(
//     'assets/songs/Blue_Eyes_Full_Video_Song_Yo_Yo_Honey_Singh___Blockbuster_Song_Of_2013(256k).mp3',
//     metas: Metas(
//       title: 'aleena',
//       artist: 'anandhu',
//       image: MetasImage.asset('assets/images/dj.jpg'),
//     ),
//   ),
// ];
