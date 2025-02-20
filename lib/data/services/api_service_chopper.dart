import 'package:chopper/chopper.dart';

part 'api_service_chopper.chopper.dart';

@ChopperApi()
abstract class ApiServiceChopper extends ChopperService {
  @GET(path: '/users')
  Future<Response> fetchUsers(); // ✅ Remove List<UserModel>

  @GET(path: '/posts')
  Future<Response> fetchPosts(); // ✅ Remove List<PostModel>

  @POST(path: '/posts')
  Future<Response> createPost(@Body() Map<String, dynamic> post);

  @PUT(path: '/posts/{id}')
  Future<Response> updatePost(
      @Path('id') int postId, @Body() Map<String, dynamic> post);

  @PATCH(path: '/posts/{id}')
  Future<Response> patchPost(
      @Path('id') int postId, @Body() Map<String, dynamic> updatedFields);

  @DELETE(path: '/posts/{id}')
  Future<Response> deletePost(@Path('id') int postId);

  static ApiServiceChopper create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://jsonplaceholder.typicode.com'),
      services: [_$ApiServiceChopper()],
      converter: const JsonConverter(), // ✅ Keep default Chopper JsonConverter
    );
    return _$ApiServiceChopper(client);
  }
}
