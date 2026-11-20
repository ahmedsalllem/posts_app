
import 'package:flutter_test/flutter_test.dart';
import 'package:posts_app/models/post_model.dart';

void main() {
  test('Post model should parse JSON correctly', () {
    final post = Post.fromJson({
      'userId': 1,
      'id': 1,
      'title': 'Test Post',
      'body': 'This is a test body',
    });

    expect(post.id, 1);
    expect(post.userId, 1);
    expect(post.title, 'Test Post');
    expect(post.body, 'This is a test body');
  });
}
