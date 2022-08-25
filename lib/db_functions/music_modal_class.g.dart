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
