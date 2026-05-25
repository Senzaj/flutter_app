import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/feed_view_model.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  final ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();

    final vm =
        Provider.of<FeedViewModel>(
          context,
          listen: false,
        );

    vm.loadRepositories();

    _scrollController.addListener(() {

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        vm.loadRepositories();
      }
    });
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
        builder: (context, vm, child) {
          if (vm.repositories.isEmpty &&
              vm.isLoading) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:
                vm.repositories.length +
                (vm.isLoading ? 1 : 0),

            itemBuilder: (context, index) {
              if (index >= vm.repositories.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child:
                        CircularProgressIndicator(),
                  ),
                );
              }

              final repo =
                  vm.repositories[index];
              return Card(

                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                              color:
                                  Colors.blue.shade100,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: Text(
                              repo.language,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.visibility,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                repo.watchers.toString(),
                              ),
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