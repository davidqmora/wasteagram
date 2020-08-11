class Post {
  DateTime date;
  int count;
  String location;
  String imageUrl;

  Post();

  Post.fromMap(Map<String, dynamic> post) {
    date = post['date'].toDate();
    count = post['count'];
    location = post['location'];
    imageUrl = post['image_url'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'count': count,
      'location': location,
      'image_url': imageUrl
    };
  }
}
