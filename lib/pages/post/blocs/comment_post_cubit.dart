import 'package:demo_stream_repo_bloc/pages/post/blocs/comment_post_state.dart';
import 'package:demo_stream_repo_bloc/repository/impl/impl_post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPostCubit extends Cubit<CommentPostState> {
  CommentPostCubit() : super(InitialCommentPostState());

  // ignore: non_constant_identifier_names
  Future<void> commentToPost(int? idPost, String comment) async {
    emit(LoadingCommentPostState());
    ImplPostRepository repository = ImplPostRepository();

    try {
      // Call API
      await repository.addComment(idPost: idPost, comment: comment);

      emit(CommentPostSuccessState('200', 'Comment success'));
    } catch (e) {
      print(e);
      emit(ErrorCommentPostState(e.toString()));
    }
  }

  void resetState() {
    emit(InitialCommentPostState());
  }
}
