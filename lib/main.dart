import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';
import 'package:music_sample/screens/now_playing_screen_duplicate.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_sample/screens/splash_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
    Hive.registerAdapter(MusicModelAdapter());
  //}
  // await Hive.openBox<MusicModel>('music_db');
  runApp(const Music());
}

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      //DupeNowPlayingScreen(),
       SplashScreen(),
    );
  }
}
