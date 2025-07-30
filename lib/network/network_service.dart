import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class NetworkService {
  final String baseUrl;

  NetworkService({required this.baseUrl});

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ?? _defaultHeaders,
    );
    return _processResponse(response, 'GET $endpoint');
  }

  Future<dynamic> post(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ?? _defaultHeaders,
      body: jsonEncode(body),
    );
    return _processResponse(response, 'POST $endpoint');
  }

  Future<dynamic> patch(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ?? _defaultHeaders,
      body: jsonEncode(body),
    );
    return _processResponse(response, 'PATCH $endpoint');
  }

  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers ?? _defaultHeaders,
    );
    _processResponse(response, 'DELETE $endpoint');
  }

  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  dynamic _processResponse(http.Response response, String action) {
    log('$action: ${response.statusCode}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception('Network error [$action]: ${response.statusCode}');
    }
  }
}
