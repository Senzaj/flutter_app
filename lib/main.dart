import 'package:flutter/material.dart';
import 'package:flutter_app/feed/feed_view.dart';
import 'package:flutter_app/feed/feed_view_model.dart';
import 'package:flutter_app/onboarding_screen/onboarding_view.dart';
import 'package:flutter_app/services/github_api_service.dart';
import 'package:flutter_app/splash_screen/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => FeedViewModel(apiService: GithubApiService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(
          nextScreen: const OnboardingView(
            nextScreen: FeedView(),
          )
        ),
      ),
    );
  }
}