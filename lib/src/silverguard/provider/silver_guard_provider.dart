import 'dart:convert';

import 'package:silverguard/src/core/network/api_service.dart';
import 'package:silverguard/src/silverguard/model/request_list_url_model.dart';
import 'package:silverguard/src/silverguard/model/request_url_model.dart';
import 'package:silverguard/src/silverguard/model/response_url_model.dart';

class SilverGuardProvider extends ApiService {
  final String apiKey;
  final String baseUrl;

  const SilverGuardProvider(
    super._client, {
    required this.apiKey,
    required this.baseUrl,
  });

  Map<String, String> get headers => {
    "Authorization": "Bearer $apiKey",
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Cache-Control": "no-cache",
    "Connection": "keep-alive",
  };

  Future<String> _makePost(String path, Map<String, dynamic> body) async {
    try {
      final result = await postApi(
        baseUrl,
        headers: headers,
        path,
        body,
        (value) => ResponseUrlModel.fromJson(json.decode(value)),
      );

      if (result.httpResponseStatusEnum == HttpResponseStatusEnum.error) {
        throw Exception(result.message);
      }

      return result.dataValue!.data.url;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> postMedRequest(RequestUrlModel request) =>
      _makePost("/api/v1/med-requests", request.toJson());

  Future<String> listUrl(RequestListUrlModel request) =>
      _makePost("/api/v1/med-requests/list-url", request.toJson());
}
