import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';

ValueNotifier<List<MusicModel>> musicValueNotifier = ValueNotifier([]);

Future<void> addMusicList(MusicModel value) async {
  final musicListDb = await Hive.openBox<MusicModel>('music_db');
  final id = await musicListDb.add(value);
  value.id = id;

  musicValueNotifier.value.add(value);
  final musicListData = MusicModel(path: value.path, id: id);
  musicListDb.put(id, musicListData);
  log('musiclistlllllllllllllllllllllllllllllllll$musicListData');
  musicValueNotifier.notifyListeners();
}

Future<void> getAllStudentDetails() async {
  final musicListDb = await Hive.openBox<MusicModel>('music_db');
  musicValueNotifier.value.clear();
   musicValueNotifier.value.addAll(musicListDb.values);
  
  //  log('musicgettttttttttttttttttttttttttttttttttttttttttttttt $k');

  musicValueNotifier.notifyListeners();
}
