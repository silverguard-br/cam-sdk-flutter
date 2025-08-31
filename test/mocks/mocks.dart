import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:silverguard/silverguard.dart';
import 'package:silverguard/src/core/network/api_service.dart';
import 'package:silverguard/src/core/webview/webview.dart';
import 'package:silverguard/src/silverguard/provider/silver_guard_provider.dart';

class MockSilverGuardProvider extends Mock implements SilverGuardProvider {}

class MockRequestUrlModel extends Mock implements RequestUrlModel {}

class MockRequestListUrlModel extends Mock implements RequestListUrlModel {}

class MockApiService extends Mock implements ApiService {}

class MockClient extends Mock implements http.Client {}

class MockBuildContext implements BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockWebView extends Mock implements Webview {
  @override
  void config(String url) {}

  @override
  Widget open() {
    return Container();
  }
}
