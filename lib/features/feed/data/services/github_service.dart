import 'package:dio/dio.dart';

class GithubService {

  final Dio _dio = Dio();

  Future<List<dynamic>> fetchRepositories(int page) async {

    final response = await _dio.get(

      'https://api.github.com/orgs/facebook/repos',

      queryParameters: {
        'page': page,
        'per_page': 8,
      },
    );

    return response.data;
  }
}