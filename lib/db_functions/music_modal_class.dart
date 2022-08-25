import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'music_modal_class.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? path;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? album;

  @HiveField(4)
  String duration;

  MusicModel({
    this.id,
    required this.title,
    required this.path,
    required this.album,
    required this.duration,

    // required this.albums,
  });
}

String boxname = "musics";

class StorageBox {
  static Box<List>? _box;
  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
