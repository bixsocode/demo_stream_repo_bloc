import 'package:demo_stream_repo_bloc/pages/post/blocs/comment_post_cubit.dart';
import 'package:demo_stream_repo_bloc/pages/post/ui/create_comment_screen.dart';
import 'package:demo_stream_repo_bloc/pages/post/ui/post_screen.dart';
import 'package:demo_stream_repo_bloc/repository/impl/impl_post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;
    switch (name) {
      case RouterName.initScreen:
        screen = const PostScreen();
        break;

      case RouterName.postScreen:
        screen = const PostScreen();
        break;

      case RouterName.createCommentScreen:
        screen = BlocProvider(
            create: (context) => CommentPostCubit(),
            child: const CreateCommentScreen());
        break;

      default:
        screen = const PostScreen();
        break;
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  };
}

abstract class RouterName {
  static const String initScreen = '/';
  static const String postScreen = '/postScreen';
  static const String createCommentScreen = '/createCommentScreen';
}
