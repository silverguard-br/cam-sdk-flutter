import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:silverguard/src/silverguard/model/request_list_url_model.dart';
import 'package:silverguard/src/silverguard/model/request_url_model.dart';
import 'package:silverguard/src/silverguard/provider/silver_guard_provider.dart';

import '../../../mocks/mocks.dart';

void main() {
  late SilverGuardProvider provider;
  late MockClient mockClient;
  final baseUrl = 'example.com';

  setUp(() {
    mockClient = MockClient();
    provider = SilverGuardProvider(
      mockClient,
      apiKey: 'test-api-key',
      baseUrl: baseUrl,
    );
  });

  void whenPost(Uri uri, Object body) {
    when(
      () => mockClient.post(uri, headers: provider.headers, body: body),
    ).thenAnswer(
      (_) async => http.Response(
        json.encode({
          "data": {"url": "https://returned-url.com"},
        }),
        200,
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  group('SilverGuardProvider', () {
    test('headers returns correct values', () {
      expect(provider.headers, {
        "Authorization": "Bearer test-api-key",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Cache-Control": "no-cache",
        "Connection": "keep-alive",
      });
    });

    test('postMedRequest returns url on success', () async {
      final request = RequestUrlModel(
        transactionId: 'tx123',
        transactionAmount: 100,
        transactionTime: '2024-06-01T12:00:00Z',
      );

      final uri = Uri.https(baseUrl, '/api/v1/med-requests');
      whenPost(uri, jsonEncode(request.toJson()));

      final url = await provider.postMedRequest(request);
      expect(url, 'https://returned-url.com');
    });

    test('listUrl returns url on success', () async {
      final request = RequestListUrlModel(reporterClientId: 'client123');

      final uri = Uri.https(baseUrl, '/api/v1/med-requests/list-url');
      whenPost(uri, jsonEncode(request.toJson()));

      final url = await provider.listUrl(request);
      expect(url, 'https://returned-url.com');
    });
  });
}
