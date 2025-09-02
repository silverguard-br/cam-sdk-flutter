import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/silverguard.dart';

void main() {
  group('RequestListUrlModel', () {
    test('should create instance with given reporterClientId', () {
      const model = RequestListUrlModel(reporterClientId: 'abc123');
      expect(model.reporterClientId, 'abc123');
    });

    test('toJson should return correct map', () {
      const model = RequestListUrlModel(reporterClientId: 'xyz789');
      final json = model.toJson();
      expect(json, {'reporter_client_id': 'xyz789'});
    });
  });
}
