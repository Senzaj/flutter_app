import 'package:flutter/material.dart';
import 'package:flutter_app/feed/feed_view_model.dart';
import 'package:provider/provider.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<FeedViewModel>(context, listen: false,);
    viewModel.fetchRepos();

    _scrollController.addListener((){
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        viewModel.fetchRepos();
      }});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Repositories'),
      ),
      body: Consumer<FeedViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.repos.isEmpty && viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: viewModel.repos.length + (viewModel.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= viewModel.repos.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final repo = viewModel.repos[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repo.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        repo.description,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(repo.language,),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.visibility,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(repo.watchers.toString(),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key, required this.repoName,
    required this.repoDescription,
    required this.repoLanguage,
    required this.repoWatchers
  });

  final String repoName;
  final String repoDescription;
  final String repoLanguage;
  final int repoWatchers;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repoName),
      subtitle: Text(repoDescription),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(repoLanguage),
          Row (
            children: [
              Icon(Icons.visibility, size: 16),
              Text(repoWatchers.toString()),
            ],
          ),
        ],
      ),
    );
  }
}