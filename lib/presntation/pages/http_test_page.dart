import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/http/api_bloc.dart';
import '../bloc/api_event.dart';
import '../bloc/api_state.dart';

class HttpTestPage extends StatelessWidget {
  const HttpTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HTTP API Test")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocHttp>().add(const FetchUsersEvent());
                },
                child: const Text("Fetch Users (GET)"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBlocHttp>().add(const FetchPostsEvent());
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
                  // Implement Create Post Event
                },
                child: const Text("Create Post (POST)"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement Update Post Event
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
                  // Implement Patch Post Event
                },
                child: const Text("Patch Post (PATCH)"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement Delete Post Event
                },
                child: const Text("Delete Post (DELETE)"),
              ),
            ],
          ),

          // Display API Data
          Expanded(
            child: BlocBuilder<ApiBlocHttp, ApiState>(
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
