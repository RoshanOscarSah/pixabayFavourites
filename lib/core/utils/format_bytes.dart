class FormatBytes {
  static String formatShort(int bytes) {
    if (bytes < 0) return '0';
    const int k = 1024;
    const int m = 1024 * 1024;
    const int g = 1024 * 1024 * 1024;

    if (bytes < k) {
      return '$bytes';
    } else if (bytes < m) {
      final double value = bytes / k;
      return _formatOneDecimal(value) + 'K';
    } else if (bytes < g) {
      final double value = bytes / m;
      return _formatOneDecimal(value) + 'M';
    } else {
      final double value = bytes / g;
      return _formatOneDecimal(value) + 'GB';
    }
  }

  static String _formatOneDecimal(double value) {
    final double roundedToOne = (value * 10).round() / 10.0;
    final bool hasDecimal = (roundedToOne - roundedToOne.truncateToDouble()).abs() > 0.000001;
    return hasDecimal ? roundedToOne.toStringAsFixed(1) : roundedToOne.toStringAsFixed(0);
  }
}


