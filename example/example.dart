import 'package:time_since/time_since.dart';

void main() {
  // Example 1: Basic usage with DateTime
  void basicDateTimeExample() {
    final now = DateTime.now();
    final pastTime = now.subtract(const Duration(hours: 5));
    print(timeSince(pastTime)); // "5 hours ago"
  }

  // Example 2: Using Unix timestamp
  void unixTimestampExample() {
    final timestampInSeconds = 1698422400; // October 27, 2023
    print(timeSince(timestampInSeconds)); // Results vary based on current date
  }

  // Example 3: Custom formatting options
  void customFormattingExample() {
    final now = DateTime.now();
    final pastTime = now.subtract(const Duration(days: 45));

    final options = TimeFormatOptions(
      addAgo: false, // Don't append "ago"
      maxPrecision: 2, // Show two units
    );

    print(timeSince(pastTime, options)); // "1 month, 15 days"
  }

  // Example 4: Working with very recent times
  void recentTimesExample() {
    final now = DateTime.now();
    final justNow = now.subtract(const Duration(seconds: 10));
    final almostNow = now.subtract(const Duration(seconds: 45));

    // Default threshold is 30 seconds
    print(timeSince(justNow)); // "just now"
    print(timeSince(almostNow)); // "45 seconds ago"

    // Custom threshold
    final options = TimeFormatOptions(justNowThreshold: 60);
    print(timeSince(almostNow, options)); // "just now"
  }

  // Example 5: High precision formatting
  void highPrecisionExample() {
    final now = DateTime.now();
    final pastTime = now.subtract(const Duration(
      days: 400,
      hours: 5,
      minutes: 30,
    ));

    final options = TimeFormatOptions(
      maxPrecision: 3,
      addAgo: true,
    );

    print(timeSince(pastTime, options)); // "1 year, 1 month, 5 days ago"
  }

  // Example 6: Error handling
  void errorHandlingExample() {
    try {
      // Invalid input type
      print(timeSince("not a valid time"));
    } catch (e) {
      print('Error: $e');
      // Prints: Error: Invalid time input. Expected Unix timestamp (int) or DateTime object
    }
  }

  // Running the examples
  basicDateTimeExample();
  unixTimestampExample();
  customFormattingExample();
  recentTimesExample();
  highPrecisionExample();
  errorHandlingExample();
}
