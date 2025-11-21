import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/silverguard.dart';

void main() {
  group('RequestListUrlModel', () {
    test('should create instance with given reporterClientId', () {
      const model = RequestListUrlModel(reporterClientId: 'abc123');
      expect(model.reporterClientId, 'abc123');
    });

    test('should create instance with optional values', () {
      const model = RequestListUrlModel(
        reporterClientId: 'abc123',
        reporterBranchNumber: 001,
        reporterAccountNumber: 1234567,
      );
      expect(model.reporterClientId, 'abc123');
      expect(model.reporterBranchNumber, 1);
      expect(model.reporterAccountNumber, 1234567);
    });

    test('toJson should return correct map', () {
      const model = RequestListUrlModel(reporterClientId: 'xyz789');
      final json = model.toJson();
      expect(json, {'reporter_client_id': 'xyz789'});
      expect(json.containsKey("reporter_branch_number"), false);
      expect(json.containsKey("reporter_account_number"), false);
    });

    test('toJson should return correct map with optional values', () {
      const model = RequestListUrlModel(
        reporterClientId: 'xyz789',
        reporterBranchNumber: 001,
        reporterAccountNumber: 1234567,
      );
      final json = model.toJson();
      expect(json, {
        'reporter_client_id': 'xyz789',
        'reporter_branch_number': '1',
        'reporter_account_number': '1234567',
      });
    });
  });
}
