import 'package:time_since/time_since.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    DateTime currentTime = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    DateTime twoDaysAgo = DateTime.now().subtract(Duration(days: 2));
    
    DateTime oneMonthAgo = DateTime(
    DateTime.now().year,
    DateTime.now().month - 1, // Subtract one month
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second
);

    setUp(() {
      // Additional setup goes here.
    });

    test('current time should return just now', () {
      expect(timeSince(currentTime), 'just now');
    });
    test('current time minus 1 day should return 1 day ago', () {
      expect(timeSince(yesterday), '1 day ago');
    });
    test('current time minus 2 days should return 2 days ago', () {
      expect(timeSince(twoDaysAgo), '2 days ago');
    });
    test('current time minus 1 month should return 1 month ago', () {
      expect(timeSince(oneMonthAgo), '1 month ago');
    });
  });
}
