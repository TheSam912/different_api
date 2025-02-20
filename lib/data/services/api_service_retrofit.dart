import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';

part 'api_service_retrofit.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiServiceRetrofit {
  factory ApiServiceRetrofit(Dio dio, {String baseUrl}) = _ApiServiceRetrofit;

  @GET("/users")
  Future<List<UserModel>> fetchUsers();

  @GET("/posts")
  Future<List<PostModel>> fetchPosts();

  @POST("/posts")
  Future<PostModel> createPost(@Body() PostModel post);

  @PUT("/posts/{id}")
  Future<PostModel> updatePost(@Path("id") int postId, @Body() PostModel post);

  @PATCH("/posts/{id}")
  Future<PostModel> patchPost(@Path("id") int postId, @Body() Map<String, dynamic> updatedFields);

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int postId);
}