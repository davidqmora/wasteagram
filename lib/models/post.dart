class Post {
  DateTime date;
  int count;
  double longitude;
  double latitude;
  String imageUrl;

  Post();

  Post.fromMap(Map<String, dynamic> post) {
    date = post['date'].toDate();
    count = post['count'];
    longitude = post['lon'];
    latitude = post['lat'];
    imageUrl = post['image_url'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'count': count,
      'lon': longitude ?? 0,
      'lat': latitude ?? 0,
      'image_url': imageUrl
    };
  }
}
