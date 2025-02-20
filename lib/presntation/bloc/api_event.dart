import 'package:equatable/equatable.dart';
import '../../data/models/post_model.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent(); // Ensure a proper constructor

  @override
  List<Object> get props => [];
}

// Fetch Users Event
class FetchUsersEvent extends ApiEvent {
  const FetchUsersEvent();
}

// Fetch Posts Event
class FetchPostsEvent extends ApiEvent {
  const FetchPostsEvent();
}

// Create Post Event
class CreatePostEvent extends ApiEvent {
  final String title;
  final String body;
  final int userId;

  const CreatePostEvent(
      {required this.title, required this.body, required this.userId});

  @override
  List<Object> get props => [title, body, userId];
}

// Update Post Event
class UpdatePostEvent extends ApiEvent {
  final int postId;
  final PostModel post;

  const UpdatePostEvent({required this.postId, required this.post});

  @override
  List<Object> get props => [postId, post];
}

// Patch Post Event
class PatchPostEvent extends ApiEvent {
  final int postId;
  final Map<String, dynamic> updatedFields;

  const PatchPostEvent({required this.postId, required this.updatedFields});

  @override
  List<Object> get props => [postId, updatedFields];
}

// Delete Post Event
class DeletePostEvent extends ApiEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
