import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/silverguard.dart';

void main() {
  group('RequestUrlModel', () {
    test('toJson returns correct map with all fields', () {
      final model = RequestUrlModel(
        transactionId: 'tx123',
        transactionAmount: 100.5,
        transactionTime: '2024-06-01T12:00:00Z',
        transactionDescription: 'Test transaction',
        reporterClientName: 'Alice',
        reporterClientId: 'client123',
        contestedParticipantId: 'participant456',
        counterpartyClientName: 'Bob',
        counterpartyClientId: 'client789',
        counterpartyClientKey: 'key987',
        protocolId: 'protocol321',
        pixAuto: true,
        clientId: 'client999',
        clientSince: '2020-01-01',
        clientBirth: '1990-05-05',
        autofraudRisk: true,
      );

      expect(model.toJson(), {
        "transaction_id": 'tx123',
        "transaction_amount": 100.5,
        "transaction_time": '2024-06-01T12:00:00Z',
        "transaction_description": 'Test transaction',
        "reporter_client_name": 'Alice',
        "reporter_client_id": 'client123',
        "contested_participant_id": 'participant456',
        "counterparty_client_name": 'Bob',
        "counterparty_client_id": 'client789',
        "counterparty_client_key": 'key987',
        "protocol_id": 'protocol321',
        "pix_auto": true,
        "client_id": 'client999',
        "client_since": '2020-01-01',
        "client_birth": '1990-05-05',
        "autofraud_risk": true,
      });
    });

    test('toJson omits null optional fields', () {
      final model = RequestUrlModel(
        transactionId: 'tx456',
        transactionAmount: 50.0,
        transactionTime: '2024-06-02T15:30:00Z',
      );

      final json = model.toJson();

      expect(json["transaction_id"], 'tx456');
      expect(json["transaction_amount"], 50.0);
      expect(json["transaction_time"], '2024-06-02T15:30:00Z');
      expect(json["pix_auto"], false);
      expect(json["autofraud_risk"], false);

      expect(json.containsKey("transaction_description"), false);
      expect(json.containsKey("reporter_client_name"), false);
      expect(json.containsKey("reporter_client_id"), false);
      expect(json.containsKey("contested_participant_id"), false);
      expect(json.containsKey("counterparty_client_name"), false);
      expect(json.containsKey("counterparty_client_id"), false);
      expect(json.containsKey("counterparty_client_key"), false);
      expect(json.containsKey("protocol_id"), false);
      expect(json.containsKey("client_id"), false);
      expect(json.containsKey("client_since"), false);
      expect(json.containsKey("client_birth"), false);
    });

    test('pixAuto and autofraudRisk default to false', () {
      final model = RequestUrlModel(
        transactionId: 'tx789',
        transactionAmount: 200.0,
        transactionTime: '2024-06-03T10:00:00Z',
      );

      expect(model.pixAuto, false);
      expect(model.autofraudRisk, false);
    });

    test('pixAuto and autofraudRisk can be set to true', () {
      final model = RequestUrlModel(
        transactionId: 'tx101',
        transactionAmount: 300.0,
        transactionTime: '2024-06-04T09:00:00Z',
        pixAuto: true,
        autofraudRisk: true,
      );

      expect(model.pixAuto, true);
      expect(model.autofraudRisk, true);
    });
  });
}
