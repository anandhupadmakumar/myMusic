import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../play_operations/play_pause.dart';
import '../screens/now_playing_screen.dart';
import '../screens/now_playing_screen_duplicate.dart';
import 'home_listview.dart';
import 'home_listview.dart';

// Widget realtimeHomeListview(AssetsAudioPlayer assetsAudioPlayer,List audioList) {
  
//   return SafeArea(
//     child: ListView.separated(
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {
//               if (assetsAudioPlayer.current.value != null) {
//                 assetsAudioPlayer.stop();
//               }
//               assetsAudioPlayer.playlistPlayAtIndex(index);

//               // playMusic(index: index, assetsAudioplayer: assetAudioPlayer);

//               //   Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (context) {
//               //       return DupeNowPlayingScreen(au
//               //         index: index,
//               //       );
//               //     },
//               //   )

//               //       //     builder: (ctx) =>
//               //       // NOwPlayingScreen(
//               //       //       realtimePlayingInfos: realtimePlayingInfos,
//               //       //       index: index,
//               //       //       assetsAudioPlayer: assetAudioPlayer,
//               //       //     ),
//               //       //   ),
//               //       );
//             },
//             leading: CircleAvatar(
//               maxRadius: 30,
//               // backgroundImage: AssetImage(
//               // realtimePlayingInfos.current!.audio.audio.metas.image!.path),
//               backgroundImage: AssetImage(
//                 audioList[index],
//               ),

//               //AssetImage(audioList[index].metas.image!.path),
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
//               //realtimePlayingInfos.current!.audio.audio.metas.title!,
//               audioList[index],
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
//         itemCount: audioList.length),
//   );
// }

