import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/routes.dart';
import 'package:wasteagram/screens/post_view_screen.dart';
import 'package:wasteagram/widgets/chrome.dart';
import 'package:wasteagram/widgets/wait_spinner.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Post> _posts;
  Widget contents;

  @override
  Widget build(BuildContext context) {
    return getListing();
  }

  FloatingActionButton addEntryButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => savePost(context),
      tooltip: 'Add new post',
      child: Icon(Icons.camera_alt),
    );
  }

  Widget getListing() {
    return StreamBuilder(
        stream: getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.documents != null &&
              snapshot.data.documents.length > 0) {
            return Chrome(
              title: 'Wasteagram - ${snapshot.data.documents.length}',
              body: postsList(snapshot),
              actionButton: addEntryButton(context),
            );
          } else {
            return Chrome(
              body: WaitSpinner(),
            );
          }
        });
  }

  Stream<QuerySnapshot> getAllPosts() =>
      Firestore.instance.collection('posts').snapshots();

  ListView postsList(AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          var post = snapshot.data.documents[index];
          return ListTile(
              title: Text(DateFormat.yMMMd().format(post["date"].toDate())),
              trailing: Text('${post["count"]}'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PostViewScreen(snapshot.data.documents[index]),
                ));
              });
        });
  }

  Future<void> savePost(context) async {
    var picker = ImagePicker();
    PickedFile image;
    try {
      image = await picker.getImage(source: ImageSource.camera);
    } on PlatformException catch (e) {}

    if (image != null) {
      await Navigator.of(context).pushNamed(Routes.newPost, arguments: image);
      var posts = await getAllPosts().toList();
      debugPrint(posts.toString());
    }

    setState(() {
//      _posts = posts;
    });
  }
}
