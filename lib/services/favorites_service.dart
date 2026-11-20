
import 'package:hive/hive.dart';
import '../models/post_model.dart';

class FavoritesService {
  final Box<Post> favoritesBox;

  FavoritesService(this.favoritesBox);

  bool isFavorite(int id) {
    return favoritesBox.containsKey(id);
  }

  Future<void> toggleFavorite(Post post) async {
    if (isFavorite(post.id)) {
      await favoritesBox.delete(post.id);
    } else {
      final copy = Post(
        id: post.id,
        title: post.title,
        body: post.body,
        userId: post.userId,
      );

      await favoritesBox.put(post.id, copy);
    }
  }

  List<Post> getFavorites() {
    return favoritesBox.values.toList();
  }
}
