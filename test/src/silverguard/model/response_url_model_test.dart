import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/src/silverguard/model/response_url_model.dart';

void main() {
  group('UrlDataModel', () {
    test('fromJson should parse url correctly', () {
      final json = {'url': 'https://example.com'};
      final model = UrlDataModel.fromJson(json);

      expect(model.url, 'https://example.com');
    });
  });

  group('ResponseUrlModel', () {
    test('fromJson should parse data correctly', () {
      final json = {
        'data': {'url': 'https://example.com'},
      };
      final model = ResponseUrlModel.fromJson(json);

      expect(model.data, isA<UrlDataModel>());
      expect(model.data.url, 'https://example.com');
    });
  });
}
