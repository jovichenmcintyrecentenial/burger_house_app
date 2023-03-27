import 'package:burger_house/utils/formatters/phone_number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneNumberFormatter tests', () {
    test('formatUsingTemplate should format number correctly', () {
      final formattedNumber = PhoneNumberFormatter.formatUsingTemplate(
          number: '5980402', template: '___ ____');
      expect(formattedNumber, equals('598 0402'));
    });

    test('formatUsingTemplate should format number correctly with complex template', () {
      final formattedNumber = PhoneNumberFormatter.formatUsingTemplate(
          number: '1234567890', template: '___ ____ _ __ ___');
      expect(formattedNumber, equals('123 4567 8 90'));
    });

    test('formatUsingTemplate should format number correctly with specific template', () {
      final formattedNumber = PhoneNumberFormatter.formatUsingTemplate(
          number: '1234567890123456', template: '____-____-____-____');
      expect(formattedNumber, equals('1234-5678-9012-3456'));
    });

    test('formatUsingTemplate should format number correctly with specific template', () {
      final formattedNumber = PhoneNumberFormatter.formatUsingTemplate(
          number: '12345678901', template: '____-____-____-____');
      expect(formattedNumber, equals('1234-5678-901'));
    });


    test('cleanNumber should remove special characters', () {
      final cleanedNumber = PhoneNumberFormatter.cleanNumber(
          number: '(123) 456-7890', options: CleanType.full);
      expect(cleanedNumber, equals('1234567890'));
    });

    test('cleanNumber should allow spaces', () {
      final cleanedNumber = PhoneNumberFormatter.cleanNumber(
          number: '(123) 456-7890', options: CleanType.allowSpaces);
      expect(cleanedNumber, equals('123 456 7890'));
    });
  });
}