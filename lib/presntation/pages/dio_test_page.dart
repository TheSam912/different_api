import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../bloc/api_event.dart';
import '../bloc/api_state.dart';
import '../bloc/dio/api_bloc_dio.dart';

class DioTestPage extends StatelessWidget {
  const DioTestPage({super.key});

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dio API Test")),
      body: Column(
        children: [
          // Buttons for API Requests
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocDio>().add(const FetchUsersEvent());
                },
                child: const Text("Fetch Users (GET)"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocDio>().add(const FetchPostsEvent());
                },
                child: const Text("Fetch Posts (GET)"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocDio>().add(const CreatePostEvent(
                        title: "New Dio Post",
                        body: "This is a new post using Dio!",
                        userId: 1,
                      ));
                },
                child: const Text("Create Post (POST)"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocDio>().add(UpdatePostEvent(
                        postId: 1,
                        post: PostModel(
                            id: 1,
                            title: "Updated Dio Post",
                            body: "Updated content!",
                            userId: 1),
                      ));
                },
                child: const Text("Update Post (PUT)"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocDio>().add(const PatchPostEvent(
                        postId: 1,
                        updatedFields: {"title": "Patched Title"},
                      ));
                },
                child: const Text("Patch Post (PATCH)"),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ApiBlocDio>()
                      .add(const DeletePostEvent(postId: 1));
                },
                child: const Text("Delete Post (DELETE)"),
              ),
            ],
          ),

          // Display API Data
          Expanded(
            child: BlocConsumer<ApiBlocDio, ApiState>(
              listener: (context, state) {
                if (state is PostCreated) {
                  _showSnackbar(context, "Post Created Successfully!");
                  context
                      .read<ApiBlocDio>()
                      .add(const FetchPostsEvent()); // Refresh Posts
                } else if (state is PostUpdated) {
                  _showSnackbar(context, "Post Updated Successfully!");
                  context
                      .read<ApiBlocDio>()
                      .add(const FetchPostsEvent()); // Refresh Posts
                } else if (state is PostPatched) {
                  _showSnackbar(context, "Post Patched Successfully!");
                  context
                      .read<ApiBlocDio>()
                      .add(const FetchPostsEvent()); // Refresh Posts
                } else if (state is PostDeleted) {
                  _showSnackbar(context, "Post Deleted Successfully!");
                  context
                      .read<ApiBlocDio>()
                      .add(const FetchPostsEvent()); // Refresh Posts
                }
              },
              builder: (context, state) {
                if (state is ApiLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UsersLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.users[index].name),
                        subtitle: Text(state.users[index].email),
                      );
                    },
                  );
                } else if (state is PostsLoaded) {
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.posts[index].title),
                        subtitle: Text(state.posts[index].body),
                      );
                    },
                  );
                } else if (state is ApiError) {
                  return Center(child: Text(state.message));
                }
                return const Center(
                    child: Text("Press a button to fetch data"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
