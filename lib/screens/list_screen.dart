import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/routes.dart';
import 'package:wasteagram/services/PostDAO.dart';
import 'package:wasteagram/widgets/chrome.dart';
import 'package:wasteagram/widgets/post_list/posts_list.dart';
import 'package:wasteagram/widgets/wait_spinner.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return getListing();
  }

  Widget getListing() {
    return StreamBuilder(
        stream: PostDAO().getPosts(),
        builder: (context, snapshot) {
//          throw ("Sample crash");
          List<Post> posts;
          int itemCount = 0;
          if (snapshot.hasData && snapshot.data.documents != null) {
            posts = parsePosts(snapshot);
            posts.forEach((p) => {itemCount += p.count});
          }
          return Chrome(
            semanticTitle: getSemanticTitle(itemCount),
            title: getTitle(itemCount),
            body: screeMainWidget(posts),
            actionButton: addEntryButton(context),
          );
        });
  }

  String getTitle(int itemCount) =>
      itemCount == 0 ? 'Wasteagram' : 'Wasteagram - $itemCount';

  String getSemanticTitle(int itemCount) => itemCount == 0
      ? 'Wasteagram'
      : 'Wasteagram, total items wasted $itemCount';

  Widget screeMainWidget(List<Post> posts) => posts == null || posts.length == 0
      ? WaitSpinner()
      : PostsList(posts: posts);

  Widget addEntryButton(BuildContext context) {
    return Semantics(
      enabled: true,
      label: "Add new post button.",
      hint: "Double tap to add a new post.",
      child: ExcludeSemantics(
        child: FloatingActionButton(
          onPressed: () => savePost(context),
          tooltip: 'Add new post',
          child: Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  Future<void> savePost(context) async {
    var picker = ImagePicker();
    PickedFile image;
    try {
      image = await picker.getImage(source: ImageSource.camera);
    } on PlatformException {
      image = await picker.getImage(source: ImageSource.gallery);
    }

    if (image != null) {
      await Navigator.of(context).pushNamed(Routes.newPost, arguments: image);
    }

    setState(() {});
  }

  List<Post> parsePosts(AsyncSnapshot<dynamic> snapshot) {
    var posts = List<Post>();
    for (dynamic rawPost in snapshot.data.documents) {
      posts.add(Post.fromMap(rawPost.data));
    }
    return posts;
  }
}
