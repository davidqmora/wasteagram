import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
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
    return Firestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots();
  }

  void savePost(Post post) async {
    post.imageUrl = await _saveImage(post.imageUrl);

    await Firestore.instance.collection('posts').add(post.toMap());
  }

  Future _saveImage(String imagePath) async {
    var storage = FirebaseStorage.instance.ref().child(Uuid().v4());
    var uploadTask = storage.putFile(File(imagePath));
    await uploadTask.onComplete;

    return await storage.getDownloadURL();
  }
}
