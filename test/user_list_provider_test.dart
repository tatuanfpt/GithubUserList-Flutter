// test/user_list_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_app/models/github_user.dart';
import 'package:github_users_app/providers/user_list_provider.dart';
import 'package:github_users_app/services/database_service.dart';
import 'package:github_users_app/services/github_service.dart';
import 'package:mockito/mockito.dart';

class MockGitHubService extends Mock implements GitHubService {}

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  late UserListProvider provider;
  late MockGitHubService mockService;
  late MockDatabaseService mockDbService;

  setUp(() {
    mockService = MockGitHubService();
    mockDbService = MockDatabaseService();
    provider = UserListProvider(service: mockService, dbService: mockDbService);
  });

  test('fetchUsers adds users on success', () async {
    final mockUsers = [
      GitHubUser(id: 1, login: 'test', avatarUrl: 'https://avatar.com', htmlUrl: 'https://github.com')
    ];
    when(mockService.fetchUsers(perPage: 20, since: 0))
        .thenAnswer((_) async => mockUsers);
    when(mockDbService.insertUsers(mockUsers)).thenAnswer((_) async => {});
    when(mockDbService.fetchUsers()).thenAnswer((_) async => []);

    await provider.fetchUsers();

    expect(provider.users.length, 1);
    expect(provider.users.first.login, 'test');
    expect(provider.error, isNull);
  });

  test('fetchUsers sets error on failure', () async {
    when(mockService.fetchUsers(perPage: 20, since: 0))
        .thenThrow(Exception('Network error'));
    when(mockDbService.fetchUsers()).thenAnswer((_) async => []);

    await provider.fetchUsers();

    expect(provider.users.isEmpty, true);
    expect(provider.error, isNotNull);
  });
}