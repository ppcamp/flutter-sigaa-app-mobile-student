import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sigaa_student/services/network/agent.dart';

/// It creates a client with session support
class ClientWithSession {
  ClientWithSession() {
    var httpclient = http.Client();
    this.client = UserAgentClient(httpclient);
  }

  /// The client used to make this request
  late final UserAgentClient client;

  /// The base header, which will hold all needed cookies used in every request
  var _headers = <String, String>{};

  void _updateCookie(http.Response response) {
    this._headers = response.headers;
  }

  /// It converts a given [response] into a json object
  static toJson(http.Response response) {
    return json.decode(response.body);
  }

  /// It makes a get request.
  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    try {
      final parsedUrl = Uri.parse(url);
      var h = headers ?? this._headers;
      h.addAll(this._headers);
      var response = await client.get(parsedUrl, headers: h);
      return response;
    } catch (e) {
      client.close();
      throw e;
    }
  }

  /// It makes a post request.
  /// When making it, it'll change the the local [headers] (cookies)
  Future<http.Response> post(String url,
      {Map<String, String>? headers, Map<String, String>? payload}) async {
    try {
      print("Making request");
      final parsedUrl = Uri.parse(url);
      var h = headers ?? this._headers;
      print("Headers: $h");

      var response = await client.post(parsedUrl, body: payload, headers: h);
      this._updateCookie(response);
      print(response.headers);

      h.addAll(this._headers);
      return response;
    } catch (e) {
      client.close();
      throw e;
    }
  }

  /// It makes a put request.
  /// When making it, it'll change the the local [headers] (cookies)
  Future<http.Response> put(String url,
      {Map<String, String>? headers, Map<String, String>? payload}) async {
    try {
      final parsedUrl = Uri.parse(url);
      var h = headers ?? this._headers;
      h.addAll(this._headers);
      var response = await client.put(parsedUrl, body: payload, headers: h);
      this._updateCookie(response);
      return response;
    } catch (e) {
      client.close();
      throw e;
    }
  }
}
