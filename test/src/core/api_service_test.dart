import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:silverguard/src/core/network/api_service.dart';

import '../../mocks/mocks.dart';

void main() {
  group('ApiService', () {
    late MockClient mockClient;
    late ApiService apiService;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService(mockClient);

      registerFallbackValue(Uri.parse('https://example.com/test'));
    });

    test('getApi returns SuccessResultApi on status 200', () async {
      const baseUrl = 'example.com';
      const path = '/test';
      final responseBody = jsonEncode({'key': 'value'});

      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await apiService.getApi<Map<String, dynamic>>(
        baseUrl,
        path,
        (body) => jsonDecode(body),
      );

      expect(result, isA<SuccessResultApi<Map<String, dynamic>>>());
      expect((result as SuccessResultApi).data, {'key': 'value'});
    });

    test('getApi returns ErrorResultApi on non-200 status', () async {
      const baseUrl = 'example.com';
      const path = '/test';

      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 404));

      final result = await apiService.getApi<String>(
        baseUrl,
        path,
        (body) => body,
      );

      expect(result, isA<ErrorResultApi<String>>());
      expect((result as ErrorResultApi).errorMessage, "Something went wrong");
    });

    test('postApi returns SuccessResultApi on status 200', () async {
      const baseUrl = 'example.com';
      const path = '/test';
      final requestBody = {'foo': 'bar'};
      final responseBody = jsonEncode({'result': 'ok'});

      when(
        () => mockClient.post(
          any(),
          headers: any(named: 'headers'),
          body: jsonEncode(requestBody),
        ),
      ).thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await apiService.postApi<Map<String, dynamic>>(
        baseUrl,
        path,
        requestBody,
        (body) => jsonDecode(body),
      );

      expect(result, isA<SuccessResultApi<Map<String, dynamic>>>());
      expect((result as SuccessResultApi).data, {'result': 'ok'});
    });

    test('postApi returns ErrorResultApi on non-200 status', () async {
      const baseUrl = 'example.com';
      const path = '/test';
      final requestBody = {'foo': 'bar'};

      when(
        () => mockClient.post(
          any(),
          headers: any(named: 'headers'),
          body: jsonEncode(requestBody),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      final result = await apiService.postApi<String>(
        baseUrl,
        path,
        requestBody,
        (body) => body,
      );

      expect(result, isA<ErrorResultApi<String>>());
      expect((result as ErrorResultApi).errorMessage, "Something went wrong");
    });
  });
}
