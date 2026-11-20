
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/post_model.dart';
import '../services/post_service.dart';
import '../services/favorites_service.dart';
import 'favorites_screen.dart';

class PostsScreen extends StatefulWidget {
  final Box<Post> postsBox;
  final Box<Post> favoritesBox;

  const PostsScreen({
    super.key,
    required this.postsBox,
    required this.favoritesBox,
  });

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  bool loading = true;
  String? error;

  late FavoritesService favoritesService;

  @override
  void initState() {
    super.initState();
    favoritesService = FavoritesService(widget.favoritesBox);
    loadPosts();
  }

  Future<void> loadPosts() async {
    try {
      await PostService(widget.postsBox).fetchPosts();

      if (!mounted) return;

      setState(() {
        loading = false;
        error = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = widget.postsBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoritesBox: widget.favoritesBox,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: loading && posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : error != null && posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error!),
                      ElevatedButton(
                        onPressed: loadPosts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ValueListenableBuilder<Box<Post>>(
                  valueListenable: widget.favoritesBox.listenable(),
                  builder: (context, box, child) {
                    return RefreshIndicator(
                      onRefresh: loadPosts,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          final isFavorite =
                              favoritesService.isFavorite(post.id);

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${post.id}'),
                              ),
                              title: Text(
                                post.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                post.body,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: isFavorite
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                                onPressed: () async {
                                  await favoritesService
                                      .toggleFavorite(post);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}