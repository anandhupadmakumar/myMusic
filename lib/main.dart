import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';
import 'package:music_sample/screens/home_screen_duplicate.dart';
import 'package:music_sample/screens/now_playing_screen_duplicate.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_sample/screens/splash_screen.dart';

late Box<MusicPlayListNames> playListNamesDb;
late Box<MusicModel> allSongsDb;
late Box<MusicFavorites> favoritesDb;
late Box<MusicPlayListSongs> playListSongsDb;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
  Hive.registerAdapter(MusicModelAdapter());
  Hive.registerAdapter(MusicPlayListNamesAdapter());
  Hive.registerAdapter(MusicFavoritesAdapter());
  Hive.registerAdapter(MusicPlayListSongsAdapter());

  allSongsDb = await Hive.openBox('songs_db');
  playListNamesDb = await Hive.openBox('playlist_namesdb');
  favoritesDb = await Hive.openBox('favorite_db');
  playListSongsDb = await Hive.openBox('playlists_musicsss_db') ;

  //}
  // await Hive.openBox<MusicModel>('music_db');
  runApp(const Music());
}

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //DupeNowPlayingScreen(),
      //
    );
  }
}
