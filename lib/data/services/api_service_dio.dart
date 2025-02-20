import '../../core/dio_client.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';

class ApiServiceDio {
  final DioClient _dioClient = DioClient();

  // GET Users
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dioClient.dio.get('/users');
      return (response.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception("Dio Error: $e");
    }
  }

  // GET Posts
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dioClient.dio.get('/posts');
      return (response.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
    } catch (e) {
      throw Exception("Dio Error: $e");
    }
  }

  // POST Create a New Post
  Future<PostModel> createPost(PostModel post) async {
    try {
      final response = await _dioClient.dio.post('/posts', data: post.toJson());
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Dio Error: $e");
    }
  }

  // PUT Update a Post
  Future<PostModel> updatePost(int postId, PostModel post) async {
    try {
      final response =
          await _dioClient.dio.put('/posts/$postId', data: post.toJson());
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Dio Error: $e");
    }
  }

  // PATCH Partially Update a Post
  Future<PostModel> patchPost(
      int postId, Map<String, dynamic> updatedFields) async {
    try {
      final response =
          await _dioClient.dio.patch('/posts/$postId', data: updatedFields);
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Dio Error: $e");
    }
  }

  // DELETE a Post
  Future<bool> deletePost(int postId) async {
    try {
      final response = await _dioClient.dio.delete('/posts/$postId');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Dio Error: $e");
    }
  }
}
