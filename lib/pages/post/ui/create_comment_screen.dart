import 'package:demo_stream_repo_bloc/model/post_model.dart';
import 'package:demo_stream_repo_bloc/pages/post/blocs/comment_post_cubit.dart';
import 'package:demo_stream_repo_bloc/pages/post/blocs/comment_post_state.dart';
import 'package:demo_stream_repo_bloc/repository/impl/impl_post_repository.dart';
import 'package:demo_stream_repo_bloc/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCommentScreen extends StatefulWidget {
  const CreateCommentScreen({super.key});

  @override
  State<CreateCommentScreen> createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  PostModel? post;
  bool isLoading = true;
  TextEditingController _commentController = TextEditingController();
  late ImplPostRepository repository;
  late int postId;
  @override
  void initState() {
    super.initState();
    repository = ImplPostRepository();
    // Lấy id từ arguments
    Future.delayed(Duration.zero, () {
      setState(() {
        postId = ModalRoute.of(context)!.settings.arguments as int;
        print('postIdDDDDDDDDĐ: $postId');
      });
      _fetchPostById();
    });
  }

  Future<void> _fetchPostById() async {
    try {
      final result = await repository.getPostById(id: postId);
      setState(() {
        post = result.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
              height: 56,
              color: Color.fromARGB(255, 0, 101, 144),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouterName.postScreen);
                    },
                  ),
                  Center(
                    child: Text(
                      'Create Comment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
          post == null ? Container() : _buildCommentScreen()
        ],
      )),
    );
  }

  Widget _buildCommentScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Bài đăng của: ${post!.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 101, 144),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nội dung: ${post!.caption}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 144, 38),
              ),
            ),
          ),
          BlocBuilder<CommentPostCubit, CommentPostState>(
              builder: (context, state) {
            if (state is LoadingCommentPostState) {
              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 15, 164, 112),
              );
            } else if (state is ErrorCommentPostState) {
              return Text(state.error);
            } else if (state is CommentPostSuccessState) {
              BlocProvider.of<CommentPostCubit>(context).resetState();
              _fetchPostById();
              _commentController.clear();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments (${post!.comments!.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: post!.comments!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(post!.comments![index]),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Comment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your comment',
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (_commentController.text.isNotEmpty) {
                              BlocProvider.of<CommentPostCubit>(context)
                                  .commentToPost(
                                      postId, _commentController.text);
                            }
                          },
                          child: Text('Add Comment'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Like bài viết',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
