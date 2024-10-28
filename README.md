# time_since

A Flutter package that converts timestamps into human-readable time-ago strings (e.g., "2 hours ago", "3 months ago").

## Features

- Convert timestamps or DateTime objects into human-readable time strings
- Customizable output format
- Support for multiple time units (years, months, days, hours, minutes, seconds)
- "Just now" threshold for very recent times
- Configurable precision for time descriptions
- Automatic pluralization of time units

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  time_since: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:time_since/time_since.dart';

// Using with DateTime
final dateTime = DateTime(2024, 1, 1);
print(timeSince(dateTime)); // "3 months ago"

// Using with Unix timestamp (seconds)
final timestamp = 1704067200; // January 1, 2024
print(timeSince(timestamp)); // "3 months ago"
```

### Customizing Output

You can customize the output format using `TimeFormatOptions`:

```dart
final options = TimeFormatOptions(
  addAgo: false,         // Don't append "ago" to the result
  maxPrecision: 2,       // Show up to 2 units (e.g., "1 year, 2 months")
  justNowThreshold: 60,  // Show "just now" for times within 60 seconds
);

final time = DateTime.now().subtract(Duration(hours: 25));
print(timeSince(time, options)); // "1 day, 1 hour"
```

## API Reference

### timeSince

```dart
String timeSince(dynamic time, [TimeFormatOptions? options])
```

Formats a time into a human-readable time-ago string.

Parameters:
- `time`: Either a Unix timestamp (int) or a DateTime object
- `options`: Optional TimeFormatOptions to customize the output

Returns a formatted string like "2 hours ago" or "3 months ago".

### TimeFormatOptions

```dart
class TimeFormatOptions {
  final bool addAgo;            // Whether to append "ago" to the result
  final int maxPrecision;       // Maximum number of units to show
  final int justNowThreshold;   // Seconds threshold for "just now"
  
  const TimeFormatOptions({
    this.addAgo = true,
    this.maxPrecision = 1,
    this.justNowThreshold = 30,
  });
}
```

## Time Units

The package supports the following time units:
- Years
- Months
- Days
- Hours
- Minutes
- Seconds

Time units are automatically pluralized based on the value (e.g., "1 month" vs "2 months").

## Error Handling

The package throws an `ArgumentError` if the provided time input is invalid. Valid inputs are:
- Unix timestamps (int)
- DateTime objects

## License

MIT License - feel free to use this package in your projects.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.


## Say Hello to Jeff 👋

[personal site](https://www.jefferyabbott.com)\
[LinkedIn](https://www.linkedin.com/in/jeffery-abbott-129b1a112)
