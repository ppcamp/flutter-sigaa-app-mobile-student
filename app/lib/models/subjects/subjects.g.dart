// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsAdapter extends TypeAdapter<Subjects> {
  @override
  final int typeId = 1;

  @override
  Subjects read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subjects(
      place: fields[0] as String,
      classname: fields[1] as String,
      hour: fields[2] as String,
      period: fields[4] as String?,
      acronym: fields[3] as String?,
      updatedAt: fields[5] as DateTime?,
      url: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Subjects obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.place)
      ..writeByte(1)
      ..write(obj.classname)
      ..writeByte(2)
      ..write(obj.hour)
      ..writeByte(3)
      ..write(obj.acronym)
      ..writeByte(4)
      ..write(obj.period)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
