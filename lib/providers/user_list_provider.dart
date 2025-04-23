import 'package:flutter/material.dart';
import 'package:github_users_app/models/github_user.dart';
import 'package:github_users_app/services/database_service.dart';
import 'package:github_users_app/services/github_service.dart';

/// Manages the state of the user list
class UserListProvider with ChangeNotifier {
  final GitHubService _service;
  final DatabaseService _dbService;
  List<GitHubUser> _users = [];
  bool _isFetching = false;
  int _lastId = 0;
  static const int _perPage = 20;
  String? _error;

  UserListProvider({
    GitHubService? service,
    DatabaseService? dbService,
  })  : _service = service ?? GitHubService(),
        _dbService = dbService ?? DatabaseService.instance {
    _loadCachedUsers();
  }

  List<GitHubUser> get users => _users;
  bool get isFetching => _isFetching;
  String? get error => _error;

  Future<void> fetchUsers() async {
    if (_isFetching) return;
    _isFetching = true;
    _error = null;
    notifyListeners();

    try {
      final newUsers = await _service.fetchUsers(perPage: _perPage, since: _lastId);
      _users.addAll(newUsers);
      _lastId = newUsers.isNotEmpty ? newUsers.last.id : _lastId;
      await _dbService.insertUsers(newUsers);
      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> _loadCachedUsers() async {
    _users = await _dbService.fetchUsers();
    if (_users.isNotEmpty) {
      _lastId = _users.last.id;
      notifyListeners();
    }
    await fetchUsers(); // Fetch fresh data
  }
}