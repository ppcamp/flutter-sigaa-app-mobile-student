// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginPayloadAdapter extends TypeAdapter<LoginPayload> {
  @override
  final int typeId = 3;

  @override
  LoginPayload read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginPayload(
      login: fields[0] as String,
      password: fields[1] as String,
    )
      ..updatedAt = fields[2] as DateTime?
      ..imagePath = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, LoginPayload obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.login)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginPayloadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
