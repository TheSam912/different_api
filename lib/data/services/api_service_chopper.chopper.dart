// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service_chopper.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiServiceChopper extends ApiServiceChopper {
  _$ApiServiceChopper([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiServiceChopper;

  @override
  Future<Response<dynamic>> fetchUsers() {
    final Uri $url = Uri.parse('/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetchPosts() {
    final Uri $url = Uri.parse('/posts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createPost(Map<String, dynamic> post) {
    final Uri $url = Uri.parse('/posts');
    final $body = post;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updatePost(
    int postId,
    Map<String, dynamic> post,
  ) {
    final Uri $url = Uri.parse('/posts/${postId}');
    final $body = post;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> patchPost(
    int postId,
    Map<String, dynamic> updatedFields,
  ) {
    final Uri $url = Uri.parse('/posts/${postId}');
    final $body = updatedFields;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deletePost(int postId) {
    final Uri $url = Uri.parse('/posts/${postId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
