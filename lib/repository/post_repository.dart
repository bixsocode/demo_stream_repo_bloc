import 'dart:async';

import 'package:demo_stream_repo_bloc/model/default_data.dart';
import 'package:demo_stream_repo_bloc/model/post_model.dart';

abstract class PostRepository {
  final _controller = StreamController<List<PostModel>>();

  Stream<List<PostModel>> get items => _controller.stream.asBroadcastStream();

  void addToStream(List<PostModel> items) => _controller.sink.add(items);

  Future<DefaultModel<PostModel>> getPostById({int? id});
  Future<DefaultModel<List<PostModel>>> addComment(
      {int? idPost, String? comment});
}
