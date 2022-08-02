import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'music_modal_class.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  List<String> path;
  @HiveField(2)
  List<String> title;
  @HiveField(3)
  List<String> album;
  
  
  @HiveField(4)
 
  List<String> duration;
  

  MusicModel({
    this.id,
    required this.title,
    required this.path,
    required this.album,
    required this.duration,
    

    // required this.albums,
  });
}
