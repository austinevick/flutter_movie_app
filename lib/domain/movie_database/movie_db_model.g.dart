// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDBModelAdapter extends TypeAdapter<MovieDBModel> {
  @override
  final int typeId = 0;

  @override
  MovieDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDBModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      image: fields[2] as String?,
      date: fields[3] as DateTime?,
      isFavourite: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDBModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
