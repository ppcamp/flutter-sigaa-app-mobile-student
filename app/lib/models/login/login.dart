import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class LoginPayload {
  LoginPayload({required this.login, required this.password});

  /// [login] holds the user's cpfs
  @HiveField(0)
  String login;

  /// user's password
  @HiveField(1)
  String password;

  /// the last date where this field was updated
  @HiveField(2)
  DateTime? updatedAt; // DateTime.now();

  Map<String, String> toMap() =>
      ({"user.login": this.login, "user.senha": this.password});
}
