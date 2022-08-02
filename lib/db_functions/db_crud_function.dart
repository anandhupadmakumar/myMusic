import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';

ValueNotifier<List<MusicModel>> musicValueNotifier = ValueNotifier([]);

Future<void> addMusicList(MusicModel value) async {
  final musicListDb = await Hive.openBox<MusicModel>('music_db');
  await musicListDb.put(0, value);
 

   musicValueNotifier.value.add(value);
  // final musicListData = MusicModel(path: value.path, id: id);
  // musicListDb.put(id, musicListData);
  // log('musiclistlllllllllllllllllllllllllllllllll$musicListData');
  musicValueNotifier.notifyListeners();
}

Future<void> getAllMusicList() async {
  final musicListDb = await Hive.openBox<MusicModel>('music_db');
  musicValueNotifier.value.clear();
   musicValueNotifier.value.addAll(musicListDb.values);
  
  //  log('musicgettttttttttttttttttttttttttttttttttttttttttttttt $k');

  musicValueNotifier.notifyListeners();
}
