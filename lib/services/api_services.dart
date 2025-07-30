import 'package:postify_app/model/post_model.dart';
import 'package:postify_app/network/network_service.dart';


class PostService {
  final NetworkService _networkService = NetworkService(baseUrl: 'https://jsonplaceholder.typicode.com');

  Future<List<Post>> fetchData() async {
    final response = await _networkService.get('/posts');
    return (response as List).map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> createData(Post post) async {
    final response = await _networkService.post('/posts', post.toJson());
    return Post.fromJson(response);
  }

  Future<Post> updateData(int id, Post post) async {
    final response = await _networkService.patch('/posts/$id', post.toJson());
    return Post.fromJson(response);
  }

  Future<void> deleteData(int id) async {
    await _networkService.delete('/posts/$id');
  }
}
