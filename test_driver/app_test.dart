import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// Based on code shown in articles:
// https://flutter.dev/docs/cookbook/testing/integration/introduction
// https://blog.codemagic.io/integration-tests-codemagic/

void main() {
  group('Wasteagram App', () {
    final newPostFinder = find.byValueKey('new_post_button');

    FlutterDriver driver;

    Future<void> delay([int milliseconds = 250]) async {
      await Future<void>.delayed(Duration(milliseconds: milliseconds));
    }

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Tapping a post entry shows details view', () async {
      // Arrange
      final listTile = find.byValueKey('post_0');
      final tileDate = await driver.getText(
          find.descendant(of: listTile, matching: find.byValueKey('date')));
      final tileItemCount = await driver.getText(find.descendant(
          of: listTile, matching: find.byValueKey('item_count')));

      // Act
      driver.tap(listTile);
      await delay(700);

      // Assert
      final detailDate = await driver.getText(find.byValueKey('date'));
      final detailItemCount =
          (await driver.getText(find.byValueKey("item_count"))).split(" ")[0];

      expect(tileDate, detailDate);
      expect(tileItemCount, detailItemCount);
    });
  });
}
