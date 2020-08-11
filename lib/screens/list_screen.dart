import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/routes.dart';
import 'package:wasteagram/screens/post_view_screen.dart';
import 'package:wasteagram/services/PostDAO.dart';
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

  ListView postsList(List<Post> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          return ListTile(
              title: Text(DateFormat.yMMMd().format(post.date)),
              trailing: Text('${post.count}'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostViewScreen(post),
                ));
              });
        });
  }

  FloatingActionButton addEntryButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => savePost(context),
      tooltip: 'Add new post',
      child: Icon(Icons.camera_alt),
    );
  }

  Future<void> savePost(context) async {
    var picker = ImagePicker();
    PickedFile image;
    try {
      image = await picker.getImage(source: ImageSource.camera);
    } on PlatformException catch (e) {}

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
