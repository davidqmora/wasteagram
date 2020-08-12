import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/routes.dart';
import 'package:wasteagram/screens/post_view_screen.dart';
import 'package:wasteagram/services/PostDAO.dart';
import 'package:wasteagram/services/analytics.dart';
import 'package:wasteagram/widgets/chrome.dart';
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
          if (snapshot.hasData && snapshot.data.documents != null) {
            var posts = parsePosts(snapshot);
            int itemCount = 0;
            posts.forEach((p) => {itemCount += p.count});
            return Chrome(
              semanticTitle: "Wasteagram, total items wasted $itemCount",
              title: 'Wasteagram - $itemCount',
              body: postsList(posts),
              actionButton: addEntryButton(context),
            );
          } else {
            return Chrome(
              body: WaitSpinner(),
            );
          }
        });
  }

  Widget postsList(List<Post> posts) {
    return Semantics(
      value: 'List of wasted item posts.',
      label: 'There are ${posts.length} posts.',
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];
            return postTile(context, post);
          }),
    );
  }

  Widget postTile(BuildContext context, Post post) {
    return MergeSemantics(
      child: Semantics(
        onTapHint: "get more details",
        child: ListTile(
            title: postTitle(post),
            trailing: postItemCount(post),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostViewScreen(post),
              ));
            }),
      ),
    );
  }

  Widget postItemCount(Post post) => Semantics(
        label: 'Wasted Items',
        child: Text('${post.count}'),
      );

  Widget postTitle(Post post) => Semantics(
        label: "Date",
        child: Text(DateFormat.yMMMd().format(post.date)),
      );

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

  @override
  void initState() {
    super.initState();
    Analytics().setScreenName("Home");
  }
}
