import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async {

  group('Test functionality of number formatter', () {
    test('Format number with number decimal', () {
      final number = '10000.01';
      final expected = '10,000.01';
      final results = NumberFormatter.format(amount: number);
      expect(results, expected);
    });

    test('Format number with decimal', () {
      final number = '10000.10';
      final expected = '10,000.1';
      final results = NumberFormatter.format(
          amount: number, formatType: FormatType.noTrailingZero);
      expect(results, expected);
    });

    test('Format number', () {
      final number = '10000.';
      final expected = '10,000';
      final results = NumberFormatter.format(
          amount: number, formatType: FormatType.noTrailingZero);
      expect(results, expected);
    });

    test('Format number with number decimal', () {
      final number = '10';
      final expected = '10.00';
      final results = NumberFormatter.format(
          amount: number, formatType: FormatType.allowTrailingZero);
      expect(results, expected);
    });

    test('Format number with dp specified', () {
      final number = '0.10000100';
      final expected = '0.100001';
      final results = NumberFormatter.format(
          amount: number, formatType: FormatType.noTrailingZero, dp: 8);
      expect(results, expected);
    });

    test('Format number with dp specified', () {
      final number = '0.100001';
      final expected = '0.10000100';
      final results = NumberFormatter.format(
          amount: number, formatType: FormatType.allowTrailingZero, dp: 8);
      expect(results, expected);
    });

    test('Format number with number decimal', () {
      final number = '10';
      final expected = '10.00000000';
      final results = NumberFormatter.format(
          amount: number, formatType: FormatType.allowTrailingZero, dp: 8);
      expect(results, expected);
    });

    test('Clean number with number separator and decimal', () {
      final number = '10,000.01';
      final expected = '10000.01';
      final results = NumberFormatter.clean(number);
      expect(results, expected);
    });

    test('Clean number with number separator', () {
      final number = '10,000';
      final expected = '10000';
      final results = NumberFormatter.clean(number);
      expect(results, expected);
    });

    test('Clean number', () {
      final number = '10000';
      final expected = '10000';
      final results = NumberFormatter.clean(number);
      expect(results, expected);
    });

    test('Format currency per char if amount 0 replace zero with number', () {
      final amount = '0';
      final key = '1';

      final expected = '1';
      final results = NumberFormatter.formatPerChar(amount: amount, key: key);
      expect(results, expected);
    });

    test('Format currency per char if amount 0 append decimal', () {
      final amount = '0';
      final key = '.';

      final expected = '0.';
      final results = NumberFormatter.formatPerChar(amount: amount, key: key);
      expect(results, expected);
    });

    test('Format currency per char delete last char change to zero', () {
      final amount = '1';
      final key = 'x';

      final expected = '0';
      final results = NumberFormatter.formatPerChar(amount: amount, key: key);
      expect(results, expected);
    });

    test('Format currency per char prevent double decimal', () {
      final amount = '1.00';
      final key = '.';

      final expected = '1.00';
      final results = NumberFormatter.formatPerChar(amount: amount, key: key);
      expect(results, expected);
    });

    test('Format currency per char', () {
      final amount = '10000';
      final key = 'x';

      final expected = '1,000';
      final results = NumberFormatter.formatPerChar(amount: amount, key: key);
      expect(results, expected);
    });
  });
}
