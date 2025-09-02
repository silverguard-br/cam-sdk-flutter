import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:silverguard/src/core/network/remote_result.dart';

export 'remote_result.dart';

class ApiService {
  final http.Client _client;

  const ApiService(this._client);

  Future<RemoteResultApi<T>> getApi<T>(
    String baseUrl,
    String unencodedPath,
    T Function(dynamic value) mapper, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _client
        .get(
          Uri.https(baseUrl, unencodedPath, queryParameters),
          headers: headers,
        )
        .timeout(const Duration(seconds: 20));

    return _manageResponse(response, mapper);
  }

  Future<RemoteResultApi<T>> postApi<T>(
    String baseUrl,
    String unencodedPath,
    Map<String, dynamic>? body,
    T Function(dynamic value) mapper, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _client
        .post(
          Uri.https(baseUrl, unencodedPath, queryParameters),
          body: jsonEncode(body),
          headers: headers,
        )
        .timeout(const Duration(seconds: 20));
    return _manageResponse(response, mapper);
  }

  RemoteResultApi<T> _manageResponse<T>(
    http.Response response,
    T Function(dynamic value) mapper,
  ) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      T? mapperModel;
      mapperModel = mapper(response.body);
      return SuccessResultApi<T>(data: mapperModel);
    } else {
      return ErrorResultApi<T>(errorMessage: "Something went wrong");
    }
  }
}
