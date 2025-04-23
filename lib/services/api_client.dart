// lib/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_users_app/config.dart';

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
    final headers = {
      'Content-Type': 'application/json;charset=utf-8',
      'Accept': 'application/vnd.github.v3+json',
    };

    // Only add authorization if token is provided
    if (Config.githubToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${Config.githubToken}';
    }

    print('Making request to: $url');
    print('Headers: $headers');

    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode} - ${response.body}');
    }
  }
}