/// Represents a time division with an amount in seconds and a name
class TimeDivision {
  final int amount;
  final String name;

  const TimeDivision({required this.amount, required this.name});
}

/// List of time divisions from largest to smallest
const List<TimeDivision> timeDivisions = [
  TimeDivision(amount: 31536000, name: 'year'),
  TimeDivision(amount: 2592000, name: 'month'),
  TimeDivision(amount: 86400, name: 'day'),
  TimeDivision(amount: 3600, name: 'hour'),
  TimeDivision(amount: 60, name: 'minute'),
  TimeDivision(amount: 1, name: 'second'),
];

/// Options for formatting the time string
class TimeFormatOptions {
  /// Whether to append "ago" to the result
  final bool addAgo;

  /// Maximum number of units to show
  final int maxPrecision;

  /// Number of seconds within which to display "just now"
  final int justNowThreshold;

  const TimeFormatOptions({
    this.addAgo = true,
    this.maxPrecision = 1,
    this.justNowThreshold = 30,
  });
}

/// Formats a time into a human-readable time-ago string
/// [time] can be either a Unix timestamp (int) or a DateTime object
String timeSince(dynamic time, [TimeFormatOptions? options]) {
  final opts = options ?? const TimeFormatOptions();

  // Convert input to milliseconds since epoch
  final milliseconds = _normalizeTime(time);
  if (milliseconds == null) {
    throw ArgumentError(
        'Invalid time input. Expected Unix timestamp (int) or DateTime object');
  }

  // Calculate seconds difference
  final seconds =
      (DateTime.now().millisecondsSinceEpoch - milliseconds) ~/ 1000;
  final positiveSeconds = seconds.abs();

  // Handle very recent times
  if (positiveSeconds <= opts.justNowThreshold) {
    return 'just now';
  }

  // Find all applicable time divisions
  final parts = <Map<String, dynamic>>[];
  var remainingSeconds = positiveSeconds;

  for (final division in timeDivisions) {
    if (parts.length >= opts.maxPrecision) break;

    final value = remainingSeconds ~/ division.amount;
    if (value >= 1) {
      parts.add({
        'value': value,
        'unit': _pluralize(division.name, value),
      });
      remainingSeconds %= division.amount;
    }
  }

  // Format the string
  final timeString =
      parts.map((part) => '${part['value']} ${part['unit']}').join(', ');

  return opts.addAgo ? '$timeString ago' : timeString;
}

/// Converts various time inputs to milliseconds since epoch
int? _normalizeTime(dynamic time) {
  if (time is int) {
    // Detect if the timestamp is in seconds instead of milliseconds
    // Most Unix timestamps are 10 digits (seconds) rather than 13 digits (milliseconds)
    if (time.toString().length == 10) {
      return time * 1000;
    }
    return time;
  } else if (time is DateTime) {
    return time.millisecondsSinceEpoch;
  }
  return null;
}

/// Pluralizes a word based on count
String _pluralize(String word, int count) {
  return count == 1 ? word : '${word}s';
}
