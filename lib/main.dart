// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_users_app/providers/user_list_provider.dart';
import 'package:github_users_app/screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserListProvider()),
      ],
      child: MaterialApp(
        title: 'GitHub Users',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const UserListScreen(),
      ),
    );
  }
}