// lib/providers/user_detail_provider.dart
import 'package:flutter/material.dart';
import 'package:github_users_app/models/github_user_detail.dart';
import 'package:github_users_app/services/github_service.dart';

/// Manages the state of user details
class UserDetailProvider with ChangeNotifier {
  final GitHubService _service;
  GitHubUserDetail? _userDetail;
  String? _error;

  UserDetailProvider({GitHubService? service}) : _service = service ?? GitHubService();

  GitHubUserDetail? get userDetail => _userDetail;
  String? get error => _error;

  Future<void> fetchUserDetail(String login) async {
    _error = null;
    notifyListeners();

    try {
      _userDetail = await _service.fetchUserDetail(login);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}