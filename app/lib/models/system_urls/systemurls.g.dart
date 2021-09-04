// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_urls.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemUrlsAdapter extends TypeAdapter<SystemUrls> {
  @override
  final int typeId = 2;

  @override
  SystemUrls read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SystemUrls(
      url: fields[0] as String,
      location: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SystemUrls obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemUrlsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
