// lib/screens/user_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_users_app/providers/user_detail_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Displays detailed information about a GitHub user
class UserDetailScreen extends StatelessWidget {
  final String login;

  const UserDetailScreen({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserDetailProvider()..fetchUserDetail(login),
      child: Scaffold(
        appBar: AppBar(title: const Text('User Details')),
        body: Consumer<UserDetailProvider>(
          builder: (context, provider, child) {
            if (provider.error != null) {
              return Center(child: Text('Error: ${provider.error}'));
            }

            if (provider.userDetail == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = provider.userDetail!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: user.avatarUrl,
                    height: 100,
                    width: 100,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  const SizedBox(height: 16),
                  Text('Login: ${user.login}'),
                  Text('Location: ${user.location ?? "N/A"}'),
                  Text('Followers: ${user.followers}'),
                  Text('Following: ${user.following}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}