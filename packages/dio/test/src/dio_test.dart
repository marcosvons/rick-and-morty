// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

void main() {
  group('Dio', () {
    test('can be instantiated', () {
      expect(Dio(), isNotNull);
    });
  });
}
