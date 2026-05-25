import 'package:flutter/material.dart';
import 'package:flutter_app/features/feed/data/models/rep_model.dart';
import 'package:flutter_app/features/feed/data/repositories/feed_repository.dart';

class FeedViewModel extends ChangeNotifier {

  final FeedRepository repository;
  FeedViewModel(this.repository);
  final List<RepoModel> repositories = [];
  bool isLoading = false;
  int page = 1;

  Future<void> loadRepositories() async {

    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final newRepositories =
          await repository.getRepositories(page);
      repositories.addAll(newRepositories);
      page++;

    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}