import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../bloc/api_event.dart';
import '../bloc/api_state.dart';
import '../bloc/retrofit/api_bloc_retrofit.dart';

class RetrofitTestPage extends StatelessWidget {
  const RetrofitTestPage({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Retrofit API Test")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocRetrofit>().add(const FetchUsersEvent());
                },
                child: const Text("Fetch Users"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocRetrofit>().add(const FetchPostsEvent());
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
                  context.read<ApiBlocRetrofit>().add(const CreatePostEvent(
                        title: "New Retrofit Post",
                        body: "This is a new post using Retrofit!",
                        userId: 1,
                      ));
                },
                child: const Text("Create Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocRetrofit>().add(UpdatePostEvent(
                        postId: 1,
                        post: PostModel(
                            id: 1,
                            title: "Updated Retrofit Post",
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
                  context.read<ApiBlocRetrofit>().add(const PatchPostEvent(
                        postId: 1,
                        updatedFields: {"title": "Patched Retrofit Title"},
                      ));
                },
                child: const Text("Patch Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ApiBlocRetrofit>()
                      .add(const DeletePostEvent(postId: 1));
                },
                child: const Text("Delete Post"),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<ApiBlocRetrofit, ApiState>(
              listener: (context, state) {
                if (state is PostCreated) {
                  _showSnackBar(context, "Post Created Successfully!");
                  context.read<ApiBlocRetrofit>().add(const FetchPostsEvent());
                }
                if (state is PostUpdated) {
                  _showSnackBar(context, "Post Updated Successfully!");
                  context.read<ApiBlocRetrofit>().add(const FetchPostsEvent());
                }
                if (state is PostPatched) {
                  _showSnackBar(context, "Post Patched Successfully!");
                  context.read<ApiBlocRetrofit>().add(const FetchPostsEvent());
                }
                if (state is PostDeleted) {
                  _showSnackBar(context, "Post Deleted Successfully!");
                  context.read<ApiBlocRetrofit>().add(const FetchPostsEvent());
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
