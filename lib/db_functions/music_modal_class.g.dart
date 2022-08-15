// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_modal_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicModelAdapter extends TypeAdapter<MusicModel> {
  @override
  final int typeId = 1;

  @override
  MusicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicModel(
      id: fields[0] as int?,
      title: fields[2] as String,
      path: fields[1] as String,
      album: fields[3] as String,
      duration: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MusicModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MusicPlayListNamesAdapter extends TypeAdapter<MusicPlayListNames> {
  @override
  final int typeId = 2;

  @override
  MusicPlayListNames read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicPlayListNames(
      id: fields[0] as int?,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MusicPlayListNames obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicPlayListNamesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MusicFavoritesAdapter extends TypeAdapter<MusicFavorites> {
  @override
  final int typeId = 3;

  @override
  MusicFavorites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicFavorites(
      id: fields[0] as int?,
      path: fields[1] as String,
      title: fields[2] as String,
      album: fields[3] as String,
      duration: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MusicFavorites obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicFavoritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MusicPlayListSongsAdapter extends TypeAdapter<MusicPlayListSongs> {
  @override
  final int typeId = 4;

  @override
  MusicPlayListSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicPlayListSongs(
      id: fields[0] as int?,
      songs: fields[1] as String,
      names: fields[2] as String,
      title: fields[3] as String,
      subtitle: fields[4] as String,
      duration: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MusicPlayListSongs obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songs)
      ..writeByte(2)
      ..write(obj.names)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.subtitle)
      ..writeByte(5)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicPlayListSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
