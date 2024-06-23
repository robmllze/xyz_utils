//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:convert' show Encoding, jsonDecode;
import 'dart:typed_data' show Uint8List;

import 'package:http/http.dart' as http;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A service for making HTTP requests.
class HttpService {
  //
  //
  //

  const HttpService._();
  static const instance = HttpService._();

  //
  //
  //

  /// Sends a GET request to the specified [url].
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

  /// Sends a GET request to the specified [url] and returns the response as a
  /// JSON object.
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

  /// Sends a GET request to the specified [url] and returns the response as a
  /// Uint8List.
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

  /// Sends a POST request to the specified [url].
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

  /// Sends a POST request to the specified [url] and returns the response as a
  /// JSON object.
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

  /// Sends a POST request to the specified [url] and returns the response as a
  /// JSON object.
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

  /// Returns the current IP address of the device.
  Future<String?> getCurrentIpAddress() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['ip'];
      }
    } catch (_) {}
    return null;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const CONTENT_TYPE_APPLICATION_JSON = {'Content-Type': 'application/json'};

extension ResponseHandleExceptionsOnFutureExtension on Future<http.Response> {
  /// Handles exceptions that occur during the request.
  Future<http.Response> handleExceptions({
    final Duration timeout = const Duration(seconds: 30),
  }) {
    return this
        .timeout(
          timeout,
          onTimeout: () => http.Response.bytes(
            [],
            408,
            reasonPhrase: 'Timed out after ${timeout.inSeconds} seconds',
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

extension BodyJsonOnResponseExtension on http.Response {
  /// Returns the response body as a JSON object.
  dynamic get bodyJson {
    try {
      return jsonDecode(this.body);
    } catch (_) {
      return null;
    }
  }
}
