import 'package:json_annotation/json_annotation.dart';
import 'comment_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<CommentModel>? comments;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}