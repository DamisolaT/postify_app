import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:postify_app/model/post_model.dart';

class PostService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('$baseUrl/posts'),
    headers: {
      'Accept': 'application/json',
      'User-Agent': 'PostifyApp/1.0', 
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Post.fromJson(json)).toList();
  } else {
    log('FetchPosts: ${response.statusCode}'); 
    throw Exception('Failed to load posts');
  }
}


  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );
    log('CreatePost: ${response.statusCode}');

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<Post> updatePost(int id, Post post) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );
    log('UpdatePost: ${response.statusCode}');

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
    log('DeletePost: ${response.statusCode}');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete post');
    }
  }
}
