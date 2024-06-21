import 'package:demo_stream_repo_bloc/data.dart';
import 'package:demo_stream_repo_bloc/model/default_data.dart';
import 'package:demo_stream_repo_bloc/model/post_model.dart';
import 'package:demo_stream_repo_bloc/repository/post_repository.dart';

class ImplPostRepository extends PostRepository {
  @override
  Future<DefaultModel<PostModel>> getPostById({int? id}) {
    try {
      for (var element in posts) {
        if (element["id"] == id) {
          return Future.value(DefaultModel(
              data: PostModel.fromJson(element), message: 'Success'));
        }
      }
      throw Exception('Post not found');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<DefaultModel<List<PostModel>>> addComment(
      {int? idPost, String? comment}) async {
    try {
      // Mock implementation for adding comment
      for (var element in posts) {
        if (element["id"] == idPost) {
          final List<dynamic> comments = element["comments"];
          comments.add(comment);
          element["comments"] = comments; // Update comments in element
          return Future.value(DefaultModel(
              data: posts.map((e) => PostModel.fromJson(e)).toList(),
              message: 'Success'));
        }
      }
      throw Exception('Post not found');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void dispose() {}
}
