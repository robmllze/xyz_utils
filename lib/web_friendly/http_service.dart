//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:convert';
import 'dart:typed_data' show Uint8List;

import 'package:http/http.dart' as http;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class HttpService {
  //
  //
  //

  const HttpService._();
  static const instance = HttpService._();

  //
  //
  //

  Future<http.Response> get(
    Uri url, {
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
  }) async {
    return await http
        .get(url, headers: headers)
        .handleExceptions(timeout: timeout);
  }

  //
  //
  //

  Future<(http.Response, dynamic)> getJson(
    Uri url, {
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
  }) async {
    final response = await http
        .get(url, headers: headers)
        .handleExceptions(timeout: timeout);
    return (response, response.bodyJson);
  }

  //
  //
  //

  Future<(http.Response, Uint8List)> getBytes(
    Uri url, {
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
  }) async {
    final response = await http
        .get(url, headers: headers)
        .handleExceptions(timeout: timeout);
    return (response, response.bodyBytes);
  }

  //
  //
  //

  Future<http.Response> post(
    (Uri, Map<String, String>) composedRequest, {
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
  }) async {
    final url = composedRequest.$1;
    final body = composedRequest.$2;
    return await http
        .post(url, headers: headers, body: body)
        .handleExceptions(timeout: timeout);
  }

  //
  //
  //

  Future<(http.Response, Uint8List)> postBytes(
    (Uri, Map<String, String>) composedRequest, {
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
    Encoding? encoding,
  }) async {
    final url = composedRequest.$1;
    final body = composedRequest.$2;
    final response = await http
        .post(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
        )
        .handleExceptions(timeout: timeout);
    return (response, response.bodyBytes);
  }

  //
  //
  //

  Future<(http.Response, dynamic)> postJson(
    (Uri, Map<String, String>) composedRequest, {
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
    Encoding? encoding,
  }) async {
    final url = composedRequest.$1;
    final body = composedRequest.$2;
    final response = await http
        .post(
          url,
          headers: headers,
          body: body,
          encoding: encoding,
        )
        .handleExceptions(timeout: timeout);
    return (response, response.bodyJson);
  }

  //
  //
  //

  Future<String?> getCurrentIpAddress() async {
    try {
      final response =
          await http.get(Uri.parse("https://api.ipify.org?format=json"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData["ip"];
      }
    } catch (_) {}
    return null;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const CONTENT_TYPE_APPLICATION_JSON = {"Content-Type": "application/json"};

extension FutureResponseHandleExceptions on Future<http.Response> {
  Future<http.Response> handleExceptions({
    final Duration timeout = const Duration(seconds: 30),
  }) {
    return this
        .timeout(
          timeout,
          onTimeout: () => http.Response.bytes(
            [],
            408,
            reasonPhrase: "Timed out after ${timeout.inSeconds} seconds",
          ),
        )
        .catchError(
          (e) => http.Response.bytes(
            [],
            500,
            reasonPhrase: e.toString(),
          ),
        );
  }
}

extension ResponseBodyJson on http.Response {
  dynamic get bodyJson {
    try {
      return jsonDecode(this.body);
    } catch (_) {
      return null;
    }
  }
}
