class RepoModel {

  final String name;
  final String description;
  final String language;
  final int watchers;

  RepoModel({
    required this.name,
    required this.description,
    required this.language,
    required this.watchers,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {

    return RepoModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? 'Unknown',
      watchers: json['watchers_count'] ?? 0,
    );
  }
}