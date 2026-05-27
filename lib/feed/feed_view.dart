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
    final updatedViewModel = context.watch<FeedViewModel>();


    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook™ Repositories'),
        centerTitle: true,
        ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: updatedViewModel.repos.length + (updatedViewModel.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
               if (index >= updatedViewModel.repos.length) {
                  return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            final repo = updatedViewModel.repos[index];
            return FeedItem(
              repoName: repo.name,
              repoDescription: repo.description,
              repoLanguage: repo.language,
              repoWatchers: repo.watchers,
            );
          },
        ),
        )
        ],
      )
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