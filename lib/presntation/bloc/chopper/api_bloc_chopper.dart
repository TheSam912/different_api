import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/api_service_chopper.dart';
import '../api_event.dart';
import '../api_state.dart';
import 'dart:convert';

class ApiBlocChopper extends Bloc<ApiEvent, ApiState> {
  final ApiServiceChopper apiService;

  ApiBlocChopper({required this.apiService}) : super(ApiInitial()) {
    on<FetchUsersEvent>(_fetchUsers);
    on<FetchPostsEvent>(_fetchPosts);
    on<CreatePostEvent>(_createPost);
    on<UpdatePostEvent>(_updatePost);
    on<PatchPostEvent>(_patchPost);
    on<DeletePostEvent>(_deletePost);
  }

  Future<void> _fetchUsers(
      FetchUsersEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await apiService.fetchUsers();
      if (response.isSuccessful) {
        final List<dynamic> jsonList = json.decode(response.bodyString);
        final List<UserModel> users = jsonList
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(UsersLoaded(users));
      } else {
        emit(ApiError(
            "Failed to load users. Status Code: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ApiError("Failed to load users: $e"));
    }
  }

  Future<void> _fetchPosts(
      FetchPostsEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await apiService.fetchPosts();
      if (response.isSuccessful) {
        final List<dynamic> jsonList = json.decode(response.bodyString);
        final List<PostModel> posts =
            jsonList.map((e) => PostModel.fromJson(e)).toList();
        emit(PostsLoaded(posts));
      } else {
        emit(ApiError("Failed to load posts"));
      }
    } catch (e) {
      emit(ApiError("Failed to load posts: $e"));
    }
  }

  Future<void> _createPost(
      CreatePostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await apiService.createPost({
        "title": event.title,
        "body": event.body,
        "userId": event.userId,
      });

      if (response.isSuccessful) {
        final post = PostModel.fromJson(json.decode(response.bodyString));
        emit(PostCreated(post));
      } else {
        emit(ApiError("Failed to create post"));
      }
    } catch (e) {
      emit(ApiError("Failed to create post: $e"));
    }
  }

  Future<void> _updatePost(
      UpdatePostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response =
          await apiService.updatePost(event.postId, event.post.toJson());

      if (response.isSuccessful) {
        final updatedPost =
            PostModel.fromJson(json.decode(response.bodyString));
        emit(PostUpdated(updatedPost));
      } else {
        emit(ApiError("Failed to update post"));
      }
    } catch (e) {
      emit(ApiError("Failed to update post: $e"));
    }
  }

  Future<void> _patchPost(PatchPostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response =
          await apiService.patchPost(event.postId, event.updatedFields);

      if (response.isSuccessful) {
        final patchedPost =
            PostModel.fromJson(json.decode(response.bodyString));
        emit(PostPatched(patchedPost));
      } else {
        emit(ApiError("Failed to patch post"));
      }
    } catch (e) {
      emit(ApiError("Failed to patch post: $e"));
    }
  }

  Future<void> _deletePost(
      DeletePostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final response = await apiService.deletePost(event.postId);

      if (response.isSuccessful) {
        emit(PostDeleted(event.postId));
      } else {
        emit(ApiError("Failed to delete post"));
      }
    } catch (e) {
      emit(ApiError("Failed to delete post: $e"));
    }
  }
}
