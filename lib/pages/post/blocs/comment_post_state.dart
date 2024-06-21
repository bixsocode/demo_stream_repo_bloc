abstract class CommentPostState {}

class InitialCommentPostState extends CommentPostState {}

class LoadingCommentPostState extends CommentPostState {}

class ErrorCommentPostState extends CommentPostState {
  final String error;

  ErrorCommentPostState(this.error);
}

class CommentPostSuccessState extends CommentPostState {
  final String status;
  final String message;
  CommentPostSuccessState(this.status, this.message);
}
