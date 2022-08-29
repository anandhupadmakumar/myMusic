import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:heza/db_functions/music_modal_class.dart';
import 'package:heza/screens/home_screen_duplicate.dart';
import 'package:heza/screens/now_playing_screen_duplicate.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:heza/screens/splash_screen.dart';
final Box<List<dynamic>> box = StorageBox.getInstance();


// late Box<List<int>> favoriteSongsDb;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MusicModelAdapter());
  await Hive.openBox<List>(boxname);

  List<dynamic> favKey = box.keys.toList();
  if (!(favKey.contains('favourites'))) {
    List<dynamic> favouritesSongs = [];
    await box.put('favourites', favouritesSongs);
  }
  
  List<dynamic> playListName = box.keys.toList();
  if (!(favKey.contains('playlist_name'))) {
    List<dynamic> playlistName = [];
    await box.put('playlist_name', playlistName);
  }
 

  // if (!(boxKeys.contains(favsongs))) {
  //   List<audioModel> _favSongsList = [];
  //   dbBox.put(favsongs, _favSongsList);
  // }

  // if (!(boxKeys.contains(recent))) {
  //   List<audioModel> _recentSongsList = [];
  //   await dbBox.put(recent, _recentSongsList);
  // }
  

  // favoriteSongsDb = await Hive.openBox('favorites_songs_db');
  // if (favoriteSongsDb.isEmpty) {
  //   print('favorite is empty');
  // } else {
  //   favoriteSongsIdDb = favoriteSongsDb.get('favorites') as List<int>;
  // }

  //}
  // await Hive.openBox<MusicModel>('music_db');
  runApp(const Music());
}

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
       splitScreenMode: false,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
     designSize:const Size( 392.72727272727275, 781.0909090909091),
        builder: (
        BuildContext context,
        Widget? child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
         
         
          home: const SplashScreen(),
        );
      },


      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   home: SplashScreen(),
      //   //DupeNowPlayingScreen(),
      //   //
      // ),
    );
  }
}
