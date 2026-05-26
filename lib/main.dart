import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/data/repositories/feed_repository.dart';
import 'package:flutter_app/features/feed/data/services/github_service.dart';
import 'package:flutter_app/features/feed/viewmodel/feed_view_model.dart';
import 'package:flutter_app/features/splash/presentation/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => 
            FeedViewModel(
              FeedRepository(
                GithubService(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}