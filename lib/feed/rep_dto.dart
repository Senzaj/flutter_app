class ReposModel {

  final String name;
  final String description;
  final String language;
  final int watchers;

  ReposModel({
    required this.name,
    required this.description,
    required this.language,
    required this.watchers,
  });

  factory ReposModel.fromJson(Map<String, dynamic> json) {
    return ReposModel(
      name: json['name'] ?? 'No name',
      description: json['description'] ?? 'No description',
      language: json['language'] ?? 'No language',
      watchers: json['watchers_count'] ?? 0,
    );
  }
}