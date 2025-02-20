import '../../data/models/user_model.dart';
import '../../data/models/post_model.dart';

abstract class ApiState {
  List<Object> get props => [];
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class UsersLoaded extends ApiState {
  final List<UserModel> users;

  UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class PostsLoaded extends ApiState {
  final List<PostModel> posts;

  PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostCreated extends ApiState {
  final PostModel post;

  PostCreated(this.post);

  @override
  List<Object> get props => [post];
}

class ApiError extends ApiState {
  final String message;

  ApiError(this.message);

  @override
  List<Object> get props => [message];
}

class PostUpdated extends ApiState {
  final PostModel post;

  PostUpdated(this.post);

  @override
  List<Object> get props => [post];
}

class PostPatched extends ApiState {
  final PostModel post;

  PostPatched(this.post);

  @override
  List<Object> get props => [post];
}

class PostDeleted extends ApiState {
  final int postId;

  PostDeleted(this.postId);

  @override
  List<Object> get props => [postId];
}
