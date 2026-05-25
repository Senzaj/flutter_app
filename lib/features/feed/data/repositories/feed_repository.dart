import 'package:flutter_app/features/feed/data/models/rep_model.dart';
import 'package:flutter_app/features/feed/data/services/github_service.dart';

class FeedRepository {

  final GithubService service;

  FeedRepository(this.service);

  Future<List<RepoModel>> getRepositories(int page) async {

    final data = await service.fetchRepositories(page);

    return data.map<RepoModel>((json) {

      return RepoModel.fromJson(json);

    }).toList();
  }
}