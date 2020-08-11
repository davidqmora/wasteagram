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
      'lon': longitude,
      'lat': latitude,
      'image_url': imageUrl
    };
  }
}
