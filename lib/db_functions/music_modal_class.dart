import 'package:hive_flutter/hive_flutter.dart';
part 'music_modal_class.g.dart';


@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  List<String>? path;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? image;
  MusicModel(
      {
        this.id,
      required this.path,
      this.title,
     this.image});
}
