// lib/services/github_service.dart
import 'package:github_users_app/models/github_user.dart';
import 'package:github_users_app/models/github_user_detail.dart';
import 'package:github_users_app/services/api_client.dart';

/// Service for GitHub API calls
class GitHubService {
  final ApiClient client;
  static const String _baseUrl = 'https://api.github.com';

  GitHubService({ApiClient? client}) : client = client ?? HttpApiClient();

  /// Fetches a list of users with pagination
  Future<List<GitHubUser>> fetchUsers({required int perPage, required int since}) async {
    final url = '$_baseUrl/users?per_page=$perPage&since=$since';
    final response = await client.get(url);
    if (response is List) {
      return response.map((json) => GitHubUser.fromJson(json)).toList();
    }
    throw Exception('Invalid response format from GitHub API');
  }

  /// Fetches detailed user information
  Future<GitHubUserDetail> fetchUserDetail(String login) async {
    final url = '$_baseUrl/users/$login';
    final response = await client.get(url);
    return GitHubUserDetail.fromJson(response);
  }
}