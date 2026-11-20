
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import '../models/post_model.dart';

class PostService {
  final Box<Post> postsBox;

  PostService(this.postsBox);

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(
            Uri.parse(
              'https://jsonplaceholder.typicode.com/posts',
            ),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final List<Post> posts = data
            .map((item) => Post.fromJson(item))
            .toList();

        await postsBox.clear();

        await postsBox.putAll({
          for (final post in posts) post.id: post,
        });

        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      // Return cached posts if internet is unavailable.
      if (postsBox.isNotEmpty) {
        return postsBox.values.toList();
      }

      rethrow;
    }
  }
}
