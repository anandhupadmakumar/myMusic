import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';

ValueNotifier<List<MusicModel>> musicValueNotifier = ValueNotifier([]);
ValueNotifier<List<MusicPlayListNames>> playListNamesNotifier =ValueNotifier([]);
ValueNotifier<List<MusicFavorites>> favoriteListNotifier =ValueNotifier([]);
ValueNotifier<List<MusicPlayListSongs>> playListSongsNotifier =ValueNotifier([]);

    

// Future<void> addMusicList(MusicModel value) async {
//   final box = await Hive.openBox<MusicModel>('songs_db');
//   await box.put(value.id, value);
//   musicValueNotifier.value.add(value);

//    musicValueNotifier.value.add(value);
//   final musicListData = MusicModel(id:id,title: value.title, path: value.path, album: value.album, duration: value.path);
//  box.put(id, musicListData);
//   log('musiclistlllllllllllllllllllllllllllllllll${value.id} ');
//   musicValueNotifier.notifyListeners();
// }

// Future<void> getAllMusicList() async {
//   final musicListDb = await Hive.openBox<MusicModel>('songs_db');
//   musicValueNotifier.value.clear();
//   musicValueNotifier.value.addAll(musicListDb.values);

//   //  log('musicgettttttttttttttttttttttttttttttttttttttttttttttt $k');

//   musicValueNotifier.notifyListeners();
// }
