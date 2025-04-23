// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubUserDetail _$GitHubUserDetailFromJson(Map<String, dynamic> json) =>
    GitHubUserDetail(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      htmlUrl: json['html_url'] as String,
      location: json['location'] as String?,
      followers: (json['followers'] as num).toInt(),
      following: (json['following'] as num).toInt(),
    );

Map<String, dynamic> _$GitHubUserDetailToJson(GitHubUserDetail instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
      'location': instance.location,
      'followers': instance.followers,
      'following': instance.following,
    };
