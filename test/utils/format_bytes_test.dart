import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay_favorites/core/utils/format_bytes.dart';

void main() {
  group('FormatBytes', () {
    test('should format bytes less than 1K as plain number', () {
      expect(FormatBytes.formatShort(0), '0');
      expect(FormatBytes.formatShort(500), '500');
      expect(FormatBytes.formatShort(999), '999');
    });

    test('should format bytes less than 1M with K suffix', () {
      expect(FormatBytes.formatShort(1024), '1K');
      expect(FormatBytes.formatShort(1536), '1.5K');
      expect(FormatBytes.formatShort(2048), '2K');
      expect(FormatBytes.formatShort(5120), '5K');
      expect(FormatBytes.formatShort(97280), '95K');
    });

    test('should format bytes less than 1GB with M suffix', () {
      expect(FormatBytes.formatShort(1048576), '1M');
      expect(FormatBytes.formatShort(2097152), '2M');
      expect(FormatBytes.formatShort(2411724), '2.3M');
      expect(FormatBytes.formatShort(5242880), '5M');
    });

    test('should format bytes greater than or equal to 1GB with GB suffix', () {
      expect(FormatBytes.formatShort(1073741824), '1GB');
      expect(FormatBytes.formatShort(1288490188), '1.2GB');
      expect(FormatBytes.formatShort(2147483648), '2GB');
    });

    test('should handle negative values', () {
      expect(FormatBytes.formatShort(-100), '0');
      expect(FormatBytes.formatShort(-1), '0');
    });
  });
}

