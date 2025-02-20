import '../../core/http_client.dart';
import '../../core/failure.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';

class ApiServiceHttp {
  final HttpClientService _httpClient =
      HttpClientService(); // ✅ Use centralized client

  Future<List<UserModel>> fetchUsers() async {
    try {
      final data = await _httpClient.get("/users");
      return (data as List).map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw Failure("Failed to load users: $e");
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    try {
      final data = await _httpClient.get("/posts");
      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw Failure("Failed to load posts: $e");
    }
  }

  Future<PostModel> createPost(PostModel post) async {
    try {
      final data = await _httpClient.post("/posts", post.toJson());
      return PostModel.fromJson(data);
    } catch (e) {
      throw Failure("Failed to create post: $e");
    }
  }

  Future<PostModel> updatePost(int postId, PostModel post) async {
    try {
      final data = await _httpClient.put("/posts/$postId", post.toJson());
      return PostModel.fromJson(data);
    } catch (e) {
      throw Failure("Failed to update post: $e");
    }
  }

  Future<PostModel> patchPost(
      int postId, Map<String, dynamic> updatedFields) async {
    try {
      final data = await _httpClient.patch("/posts/$postId", updatedFields);
      return PostModel.fromJson(data);
    } catch (e) {
      throw Failure("Failed to patch post: $e");
    }
  }

  Future<bool> deletePost(int postId) async {
    try {
      return await _httpClient.delete("/posts/$postId");
    } catch (e) {
      throw Failure("Failed to delete post: $e");
    }
  }
}
