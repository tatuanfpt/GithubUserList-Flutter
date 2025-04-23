// lib/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Protocol-like interface for network requests (for testing)
abstract class ApiClient {
  Future<dynamic> get(String url);
}

/// Handles HTTP requests
class HttpApiClient implements ApiClient {
  final http.Client client;

  HttpApiClient({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<dynamic> get(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json;charset=utf-8'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}