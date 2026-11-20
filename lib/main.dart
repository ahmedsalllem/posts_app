
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/post_model.dart';
import 'screens/posts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(PostAdapter());
  }

  final postsBox = await Hive.openBox<Post>('postsBox');
  final favoritesBox = await Hive.openBox<Post>('favoritesBox');

  runApp(
    PostsApp(
      postsBox: postsBox,
      favoritesBox: favoritesBox,
    ),
  );
}

class PostsApp extends StatelessWidget {
  final Box<Post> postsBox;
  final Box<Post> favoritesBox;

  const PostsApp({
    super.key,
    required this.postsBox,
    required this.favoritesBox,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: PostsScreen(
        postsBox: postsBox,
        favoritesBox: favoritesBox,
      ),
    );
  }
}