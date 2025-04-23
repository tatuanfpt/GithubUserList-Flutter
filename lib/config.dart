// lib/config.dart
class Config {
  static const String githubToken = String.fromEnvironment(
    'GITHUB_TOKEN',
    defaultValue: '',
  );
} 