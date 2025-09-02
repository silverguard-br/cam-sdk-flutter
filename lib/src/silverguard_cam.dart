import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:silverguard/src/core/extensions/base_url.dart';
import 'package:silverguard/src/core/webview/webview_cam_widget.dart';
import 'package:silverguard/src/silverguard/model/request_list_url_model.dart';
import 'package:silverguard/src/silverguard/model/request_url_model.dart';
import 'package:silverguard/src/silverguard/provider/silver_guard_provider.dart';

typedef OnBackCallback = void Function(String backOrigin);

class SilverguardCAM {
  final SilverGuardProvider? _silverGuardService;

  SilverguardCAM._internal(this._silverGuardService);

  static SilverguardCAM? _instance;

  static SilverguardCAM get instance => _instance!;

  late final OnBackCallback? _onBackCallback;

  bool get _hasApiKey =>
      _silverGuardService?.apiKey != null &&
      _silverGuardService!.apiKey.isNotEmpty;
  bool get _hasBaseUrl =>
      _silverGuardService?.baseUrl != null &&
      _silverGuardService!.baseUrl.isNotEmpty;

 static void _checkConfig() {
    if (_instance == null || !instance._hasApiKey || !instance._hasBaseUrl) {
      throw Exception("SilverguardCAM is not inialized. Call init() first.");
    }
  }

  static void init({required String apiKey, required String baseUrl}) {
    _instance ??= SilverguardCAM._internal(
      SilverGuardProvider(
        http.Client(),
        apiKey: apiKey,
        baseUrl: baseUrl.removeHttp,
      ),
    );
  }

  static void setBackCallback(OnBackCallback onBackCallback) {
    _checkConfig();
    instance._onBackCallback = onBackCallback;
  }

  static void getRequestUrlModel(BuildContext context, RequestUrlModel model) {
    _checkConfig();
    instance._showPage(
      context,
      url: instance._silverGuardService!.postMedRequest(model),
    );
  }

  static void showList(BuildContext context, RequestListUrlModel model) {
    _checkConfig();
    instance._showPage(
      context,
      url: instance._silverGuardService!.listUrl(model),
    );
  }

  void _showPage(BuildContext context, {required Future<String> url}) {    
    Navigator.of(context).push<MaterialPageRoute>(
      MaterialPageRoute(
        builder: (context) => WebviewCAMWidget(
          loadUrl: () => url,
          onBackCallback: _onBackCallback,
        ),
      ),
    );
  }
}
