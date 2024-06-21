import 'dart:convert';

class PostModel {
  int? id;
  String? name;
  String? profile;
  String? time;
  String? caption;
  int? likes;
  List<String>? comments;

  PostModel(this.id, this.name, this.profile, this.time, this.caption,
      this.likes, this.comments);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profile': profile,
      'time': time,
      'caption': caption,
      'likes': likes,
      'comments': comments,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      map['id'],
      map['name'],
      map['profile'],
      map['time'],
      map['caption'],
      map['likes'],
      List<String>.from(map['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'caption': caption,
      'comments': comments,
    };
  }
}
