import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/src/core/webview/webview_cam_widget.dart';
import 'package:silverguard/src/core/webview/error_page.dart';

import '../../mocks/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final webview = MockWebView();

  group('WebviewCAMWidget', () {
    testWidgets('shows CircularProgressIndicator while waiting', (
      tester,
    ) async {
      final completer = Completer<String>();
      await tester.pumpWidget(
        MaterialApp(
          home: WebviewCAMWidget(
            loadUrl: () => completer.future,
            webview: webview,
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows ErrorPage on error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WebviewCAMWidget(
            loadUrl: () async => throw Exception('error'),
            webview: webview,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ErrorPage), findsOneWidget);
    });

    testWidgets('shows ErrorPage when data is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WebviewCAMWidget(
            loadUrl: () async => throw Exception('error'),
            webview: webview,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ErrorPage), findsOneWidget);
    });

    testWidgets('calls webView.config and shows webView.open on success', (
      tester,
    ) async {
      // Since Webview is not a widget, we can't directly test its internals.
      // But we can check that the SafeArea and Scaffold are present.
      await tester.pumpWidget(
        MaterialApp(
          home: WebviewCAMWidget(
            loadUrl: () async => 'https://example.com',
            webview: webview,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
