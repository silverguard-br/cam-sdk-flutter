import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:silverguard/silverguard.dart';
import 'package:silverguard/src/core/webview/webview_bridge.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_android/webview_flutter_android.dart';
// #enddocregion platform_imports

class Webview with WebviewBridge {
  final WebViewController _controller;
  final BuildContext _context;
  final OnBackCallback? _onBackCallback;

  const Webview(
    WebViewController controller,
    BuildContext context, {
    OnBackCallback? onBackCallback,
  }) : _controller = controller,
       _context = context,
       _onBackCallback = onBackCallback;

  void config(String url) {
    _setAndroidUploadFile(_controller);
    addJavaScriptChannels(_controller);

    _controller.loadRequest(Uri.parse(url));
  }

  @override
  BuildContext get context => _context;

  @override
  OnBackCallback? get onBackCallback => _onBackCallback;

  void _setAndroidUploadFile(WebViewController controller) {
    if (Platform.isAndroid) {
      final AndroidWebViewController androidController =
          controller.platform as AndroidWebViewController;
      androidController.setOnShowFileSelector((
        FileSelectorParams params,
      ) async {
        try {
          final result = await FilePicker.platform.pickFiles();
          if (result != null && result.files.single.path != null) {
            final file = File(result.files.single.path!);
            return [file.uri.toString()];
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha no upload do arquivo')),
            );
          }
        }
        return [];
      });
    }
  }

  Widget open() => WebViewWidget(controller: _controller);
}
