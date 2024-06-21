import 'dart:async';

import 'package:demo_stream_repo_bloc/data.dart';
import 'package:demo_stream_repo_bloc/model/post_model.dart';
import 'package:demo_stream_repo_bloc/repository/impl/impl_post_repository.dart';
import 'package:demo_stream_repo_bloc/routes/routes.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ImplPostRepository repository;
  late StreamSubscription<List<PostModel>> _subscription;
  List<PostModel> _posts = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    repository = ImplPostRepository();

    repository.addToStream(posts.map((e) => PostModel.fromJson(e)).toList());

    _subscription = repository.items.listen((posts) {
      setState(() {
        _posts = posts;
      });
    });

    final currentRoute = ModalRoute.of(context);
    if (currentRoute != null &&
        !currentRoute.settings.name!.contains('CreateCommentScreen')) {
      repository.addToStream(posts.map((e) => PostModel.fromJson(e)).toList());
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _posts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 181, 160, 255)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(_posts[index].name!),
                            subtitle: Text(_posts[index].time!),
                            trailing: const Icon(Icons.more_horiz),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouterName.createCommentScreen,
                                    arguments: _posts[index].id,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          ListTile(
                            title: Text('${_posts[index].likes} likes',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 101, 144))),
                            subtitle: Text(
                              '${_posts[index].comments!.length} comments',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 100, 43)),
                            ),
                          ),
                          ListTile(
                            title: Text(_posts[index].name!),
                            subtitle: Text(_posts[index].caption!),
                          ),
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
