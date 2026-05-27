import 'package:flutter/material.dart';
import 'package:flutter_app/feed/rep_dto.dart' show ReposModel;
import 'package:flutter_app/services/github_api_service.dart';

class FeedViewModel extends ChangeNotifier {
  FeedViewModel({required this.apiService});

  final GithubApiService apiService;

  List<ReposModel> repos = [];
  int page = 1;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchRepos() async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final newRepos = await apiService.getRepos(page);
      repos.addAll(newRepos);
      page++;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}