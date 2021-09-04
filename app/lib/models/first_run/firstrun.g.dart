// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_run.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirstRunAdapter extends TypeAdapter<FirstRun> {
  @override
  final int typeId = 0;

  @override
  FirstRun read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirstRun()..isConfigured = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, FirstRun obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isConfigured);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirstRunAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
