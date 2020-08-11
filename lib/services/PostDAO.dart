import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/post.dart';

class PostDAO {
  static PostDAO _instance;

  PostDAO._();

  factory PostDAO() {
    if (_instance == null) {
      _instance = PostDAO._();
    }

    return _instance;
  }

  Stream<QuerySnapshot> getPosts() {
    return Firestore.instance.collection('posts').snapshots();
  }

  void savePost(Post post) async {
    await Firestore.instance.collection('posts').add(post.toMap());
  }
}
