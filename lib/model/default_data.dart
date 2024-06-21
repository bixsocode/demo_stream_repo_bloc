import 'package:demo_stream_repo_bloc/model/post_model.dart';

class DefaultModel<T> {
  T? data;
  String? message = '';
  int? code;
  DefaultModel({
    required this.data,
    required this.message,
    this.code,
  });

  DefaultModel.fromJson(Map<String, dynamic> json) {
    try {
      switch (T) {
        case PostModel:
          data = PostModel.fromJson(json['data']) as T;
          break;
        default:
          data = json['data'];
          break;
      }
    } catch (e) {
      print('ERROR====> $e');
    }
    message = json['message'] ?? '';
    code = json['status_code'] ?? 0;
  }
}
