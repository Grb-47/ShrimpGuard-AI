import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _token;

  void setToken(String? token) {
    _token = token;
  }

  Future<dynamic> get(String path) {
    return _send(() => _client.get(_uri(path), headers: _headers));
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) {
    return _send(
      () => _client.post(
        _uri(path),
        headers: _headers,
        body: jsonEncode(body),
      ),
    );
  }

  Uri _uri(String path) => Uri.parse('${AppConfig.apiBaseUrl}$path');

  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }

  Future<dynamic> _send(Future<http.Response> Function() request) async {
    final response = await request().timeout(AppConfig.requestTimeout);
    final decoded = response.body.isEmpty ? null : jsonDecode(response.body);

    if (response.statusCode >= 400) {
      final message = decoded is Map<String, dynamic>
          ? decoded['message'] as String? ?? 'Request failed'
          : 'Request failed';
      throw ApiException(message, statusCode: response.statusCode);
    }

    return decoded;
  }
}
