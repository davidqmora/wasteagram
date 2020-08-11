import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    post.imageUrl = await saveImage(post.imageUrl);

    await Firestore.instance.collection('posts').add(post.toMap());
  }

  Future saveImage(String imagePath) async {
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    var storage =
        FirebaseStorage.instance.ref().child(imagePath + timeStamp.toString());
    var uploadTask = storage.putFile(File(imagePath));
    await uploadTask.onComplete;

    return await storage.getDownloadURL();
  }
}
