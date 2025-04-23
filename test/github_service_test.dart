// test/github_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_app/models/github_user.dart';
import 'package:github_users_app/services/api_client.dart';
import 'package:github_users_app/services/github_service.dart';
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late GitHubService service;
  late MockApiClient mockClient;

  setUp(() {
    mockClient = MockApiClient();
    service = GitHubService(client: mockClient);
  });

  test('fetchUsers returns list of users on success', () async {
    final mockUsers = [
      {'id': 1, 'login': 'test', 'avatar_url': 'https://avatar.com', 'html_url': 'https://github.com'}
    ];
    when(mockClient.get(any)).thenAnswer((_) async => mockUsers);

    final result = await service.fetchUsers(perPage: 20, since: 0);

    expect(result, isA<List<GitHubUser>>());
    expect(result.length, 1);
    expect(result.first.login, 'test');
  });

  test('fetchUsers throws exception on failure', () async {
    when(mockClient.get(any)).thenThrow(Exception('Network error'));

    expect(() => service.fetchUsers(perPage: 20, since: 0), throwsException);
  });
}
