import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'music_modal_class.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String path;
  @HiveField(2)
  String title;
  @HiveField(3)
  String album;

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

@HiveType(typeId: 2)
class MusicPlayListNames {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(1)
  MusicPlayListNames({this.id, required this.name});
}

@HiveType(typeId: 3)
class MusicFavorites {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String path;
  @HiveField(2)
  String title;
  @HiveField(3)
  String album;

  @HiveField(4)
  String duration;

  MusicFavorites(
      {this.id,
      required this.path,
      required this.title,
      required this.album,
      required this.duration});
}

@HiveType(typeId: 4)
class MusicPlayListSongs {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String songs;
  @HiveField(2)
  String names;
  @HiveField(3)
  String title;
  @HiveField(4)
  String subtitle;
  @HiveField(5)
  String duration;

  MusicPlayListSongs(
      {required this.id,
       required this.songs,
      required this.names,
       required this.title,
      required this.subtitle,
       required this.duration});
}
