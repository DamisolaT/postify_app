import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:postify_app/core/customs/custom_appbar.dart';
import 'package:postify_app/model/post_model.dart';
import 'package:postify_app/services/api_services.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostService apiService = PostService();
  late Future<List<Post>> postsFuture;
  final List<Post> localPosts = [];

  @override
  void initState() {
    super.initState();
    postsFuture = apiService.fetchPosts();
  }

  void _refreshPosts() {
    setState(() {
      postsFuture = apiService.fetchPosts();
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Posts Page', showFilterIcon: true),
      body: FutureBuilder<List<Post>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final fetchedPosts = snapshot.data ?? [];
          final allPosts = [...localPosts, ...fetchedPosts];

          if (allPosts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          return ListView.builder(
            itemCount: allPosts.length,
            itemBuilder: (context, index) {
              final post = allPosts[index];
              return GestureDetector(
                onLongPress: () => _showPostOptions(post),
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.body ?? '',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _showCreatePostDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showCreatePostDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final newPost = Post(
                id: DateTime.now().millisecondsSinceEpoch,
                userId: 1,
                title: titleController.text,
                body: bodyController.text,
              );

              try {
                await apiService.createPost(newPost);
                setState(() {
                  localPosts.insert(0, newPost);
                });
                showToast('Post created successfully');
              } catch (e) {
                showToast('Error: $e');
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditPostDialog(Post post) {
    final titleController = TextEditingController(text: post.title);
    final bodyController = TextEditingController(text: post.body);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final updatedPost = Post(
                id: post.id,
                userId: post.userId,
                title: titleController.text,
                body: bodyController.text,
              );

              try {
                await apiService.updatePost(post.id!, updatedPost);

                setState(() {
                  final index = localPosts.indexWhere((p) => p.id == post.id);
                  if (index != -1) {
                    localPosts[index] = updatedPost;
                  } else {
                    _refreshPosts();
                  }
                });

                showToast('Post updated successfully');
              } catch (e) {
                showToast('Error: $e');
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDeletePost(int postId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await apiService.deletePost(postId);

                setState(() {
                  localPosts.removeWhere((p) => p.id == postId);
                });

               // _refreshPosts();
                showToast('Post deleted successfully');
              } catch (e) {
                showToast('Error: $e');
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(Post post) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _showEditPostDialog(post);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              _confirmDeletePost(post.id!);
            },
          ),
        ],
      ),
    );
  }
}
