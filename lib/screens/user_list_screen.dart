import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_users_app/providers/user_list_provider.dart';
import 'package:github_users_app/screens/user_detail_screen.dart';

/// Displays a paginated list of GitHub users
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Users')),
      body: Consumer<UserListProvider>(
        builder: (context, provider, child) {
          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    onPressed: () => provider.fetchUsers(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.users.isEmpty && provider.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.users.length + (provider.isFetching ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.users.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = provider.users[index];
              return ListTile(
                title: Text(user.login),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(login: user.login),
                    ),
                  );
                },
              );
            },
            // Trigger pagination
            controller: ScrollController()
              ..addListener(() {
                final controller = PrimaryScrollController.of(context);
                if (controller.position.pixels >=
                    controller.position.maxScrollExtent - 200) {
                  provider.fetchUsers();
                }
              }),
          );
        },
      ),
    );
  }
}