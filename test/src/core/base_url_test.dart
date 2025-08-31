import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/src/core/extensions/base_url.dart';

void main() {
  group('BaseUrlExtension.removeHttp', () {
    test('removes http:// prefix', () {
      expect('http://example.com'.removeHttp, 'example.com');
    });

    test('removes https:// prefix', () {
      expect('https://example.com'.removeHttp, 'example.com');
    });

    test('removes trailing slash', () {
      expect('https://example.com/'.removeHttp, 'example.com');
    });

    test('removes both prefix and trailing slash', () {
      expect('http://example.com/'.removeHttp, 'example.com');
      expect('https://example.com/'.removeHttp, 'example.com');
    });

    test('does not modify string without http(s) or trailing slash', () {
      expect('example.com'.removeHttp, 'example.com');
    });

    test('removes only one trailing slash', () {
      expect('https://example.com//'.removeHttp, 'example.com/');
    });

    test('does not remove slash if not at end', () {
      expect('https://example.com/path/'.removeHttp, 'example.com/path');
      expect('https://example.com/path'.removeHttp, 'example.com/path');
    });

    test('empty string returns empty string', () {
      expect(''.removeHttp, '');
    });
  });
}
