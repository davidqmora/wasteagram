import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  group("Post class", () {
    test('Default Post constructor produces empty object.', () {
      final post = Post();

      expect(post.date, isNull);
      expect(post.latitude, isNull);
      expect(post.longitude, isNull);
      expect(post.count, isNull);
      expect(post.imageUrl, isNull);
    });

    test('Post correctly instanced from a map.', () {
      final testTime = Timestamp.now();
      final count = 10;
      final url = 'some_image_url';
      final latitude = 100.5;
      final longitude = -32.369;

      final map = {
        'date': testTime,
        'count': count,
        'image_url': url,
        'lat': latitude,
        'lon': longitude
      };

      var post = Post.fromMap(map);

      expect(post.date, testTime.toDate());
      expect(post.count, count);
      expect(post.imageUrl, url);
      expect(post.latitude, latitude);
      expect(post.longitude, longitude);
    });

    test('Post produces correct map of itself.', () {
      final testTime = DateTime.now();
      final count = 31;
      final url = 'some_other_image_url';
      final latitude = 91.0;
      final longitude = 11.12340986;

      var post = Post();
      post.date = testTime;
      post.count = count;
      post.imageUrl = url;
      post.longitude = longitude;
      post.latitude = latitude;

      var map = post.toMap();

      expect(map['date'], testTime);
      expect(map['count'], count);
      expect(map['image_url'], url);
      expect(map['lon'], longitude);
      expect(map['lat'], latitude);
    });
  });
}
