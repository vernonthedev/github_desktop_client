import 'package:flutter/material.dart';
import 'package:github/github.dart';

import 'github_oauth_credentials.dart';
import 'src/github_login.dart';
import 'src/github_summary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Desktop Client',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system, // or ThemeMode.light/dark
      home: const MyHomePage(
        title: 'GitHub Desktop Client (developed by vernonthedev)',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            elevation: 2,
          ),
          body: GitHubSummary(
            gitHub: _getGitHub(httpClient.credentials.accessToken),
          ),
        );
      }, //
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}

GitHub _getGitHub(String accessToken) {
  return GitHub(auth: Authentication.withToken(accessToken));
}
