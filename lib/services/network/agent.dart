import 'package:http/http.dart' as http;

class UserAgentClient extends http.BaseClient {
  static const String userAgent = 'SigaaStudentWrapper/0.1';
  final http.Client _inner;

  UserAgentClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    return _inner.send(request);
  }
}