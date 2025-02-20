import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/failure.dart';
import '../../../data/models/post_model.dart';
import '../../../data/services/api_service_http.dart';
import '../api_event.dart';
import '../api_state.dart';

class ApiBlocHttp extends Bloc<ApiEvent, ApiState> {
  final ApiServiceHttp apiService;

  ApiBlocHttp({required this.apiService}) : super(ApiInitial()) {
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
      final users = await apiService.fetchUsers();
      emit(UsersLoaded(users));
    } on Failure catch (e) {
      emit(ApiError(e.message));
    }
  }

  Future<void> _fetchPosts(
      FetchPostsEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final posts = await apiService.fetchPosts();
      emit(PostsLoaded(posts));
    } on Failure catch (e) {
      emit(ApiError(e.message));
    }
  }

  Future<void> _createPost(
      CreatePostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final newPost = await apiService.createPost(
        PostModel(
            id: 0, title: event.title, body: event.body, userId: event.userId),
      );
      emit(PostCreated(newPost));
    } on Failure catch (e) {
      emit(ApiError(e.message));
    }
  }

  Future<void> _updatePost(
      UpdatePostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final updatedPost = await apiService.updatePost(event.postId, event.post);
      emit(PostUpdated(updatedPost));
    } on Failure catch (e) {
      emit(ApiError(e.message));
    }
  }

  Future<void> _patchPost(PatchPostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      final patchedPost =
          await apiService.patchPost(event.postId, event.updatedFields);
      emit(PostPatched(patchedPost));
    } on Failure catch (e) {
      emit(ApiError(e.message));
    }
  }

  Future<void> _deletePost(
      DeletePostEvent event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      bool success = await apiService.deletePost(event.postId);
      if (success) {
        emit(PostDeleted(event.postId));
      } else {
        emit(ApiError("Failed to delete post"));
      }
    } on Failure catch (e) {
      emit(ApiError(e.message));
    }
  }
}
