class LoginPayload {
  LoginPayload({required this.login, required this.password});

  String login;
  String password;

  Map<String, String> toMap() => ({
    "user.login": this.login,
    "user.senha": this.password
  });
}
