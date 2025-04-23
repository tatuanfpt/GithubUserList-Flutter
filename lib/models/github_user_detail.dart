// lib/models/github_user_detail.dart
import 'package:json_annotation/json_annotation.dart';

part 'github_user_detail.g.dart';

/// Represents detailed GitHub user information
@JsonSerializable()
class GitHubUserDetail {
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String? location;
  final int followers;
  final int following;

  GitHubUserDetail({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    this.location,
    required this.followers,
    required this.following,
  });

  factory GitHubUserDetail.fromJson(Map<String, dynamic> json) => _$GitHubUserDetailFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubUserDetailToJson(this);
}