import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../../data/models/user_model.dart';
import '../bloc/api_event.dart';
import '../bloc/api_state.dart';
import '../bloc/chopper/api_bloc_chopper.dart';

class ChopperTestPage extends StatelessWidget {
  const ChopperTestPage({super.key});

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chopper API Test")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocChopper>().add(const FetchUsersEvent());
                },
                child: const Text("Fetch Users"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocChopper>().add(const FetchPostsEvent());
                },
                child: const Text("Fetch Posts"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocChopper>().add(const CreatePostEvent(
                        title: "New Chopper Post",
                        body: "This is a new post using Chopper!",
                        userId: 1,
                      ));
                },
                child: const Text("Create Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocChopper>().add(UpdatePostEvent(
                        postId: 1,
                        post: PostModel(
                            id: 1,
                            title: "Updated Chopper Post",
                            body: "Updated content!",
                            userId: 1),
                      ));
                },
                child: const Text("Update Post"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocChopper>().add(const PatchPostEvent(
                        postId: 1,
                        updatedFields: {"title": "Patched Title"},
                      ));
                },
                child: const Text("Patch Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ApiBlocChopper>()
                      .add(const DeletePostEvent(postId: 1));
                },
                child: const Text("Delete Post"),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<ApiBlocChopper, ApiState>(
              listener: (context, state) {
                if (state is PostCreated) {
                  _showSnackbar(context, "Post Created Successfully!");
                  context.read<ApiBlocChopper>().add(const FetchPostsEvent());
                }
                if (state is PostUpdated) {
                  _showSnackbar(context, "Post Updated Successfully!");
                  context.read<ApiBlocChopper>().add(const FetchPostsEvent());
                }
                if (state is PostPatched) {
                  _showSnackbar(context, "Post Patched Successfully!");
                  context.read<ApiBlocChopper>().add(const FetchPostsEvent());
                }
                if (state is PostDeleted) {
                  _showSnackbar(context, "Post Deleted Successfully!");
                  context.read<ApiBlocChopper>().add(const FetchPostsEvent());
                }
              },
              builder: (context, state) {
                if (state is ApiLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UsersLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      UserModel user = state.users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(user.id.toString()),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: Text(user.phone),
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
