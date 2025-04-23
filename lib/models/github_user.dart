// lib/models/github_user.dart
import 'package:json_annotation/json_annotation.dart';

part 'github_user.g.dart';

/// Represents a GitHub user fetched from the API
@JsonSerializable()
class GitHubUser {
  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;

  GitHubUser({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) => _$GitHubUserFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubUserToJson(this);

  // For database storage
  Map<String, dynamic> toMap() => {
        'id': id,
        'login': login,
        'avatarUrl': avatarUrl,
        'htmlUrl': htmlUrl,
      };

  factory GitHubUser.fromMap(Map<String, dynamic> map) => GitHubUser(
        id: map['id'],
        login: map['login'],
        avatarUrl: map['avatarUrl'],
        htmlUrl: map['htmlUrl'],
      );
}