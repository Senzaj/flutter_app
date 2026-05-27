import 'package:dio/dio.dart';
import 'package:flutter_app/feed/rep_dto.dart';

class GithubApiService {
  
  final Dio _dio = Dio();

  Future<List<ReposModel>> getRepos(int page) async {
    try {
      final response = await _dio.get(
      'https://api.github.com/orgs/facebook/repos',
      queryParameters: {
        'page': page,
        'per_page': 8,
      },
    );
      if (response.statusCode == 200) {
        return List<ReposModel>.from(response.data.map((x) => ReposModel.fromJson(x)));
      }
      else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } on DioException catch (dEx) {
      throw Exception('Dio error: ${dEx.message}');
    } catch (ex) {
      throw Exception('Unexpected error: ${ex.toString()}');
    }
  } 
}