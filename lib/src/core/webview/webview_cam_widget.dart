import 'package:flutter/material.dart';
import 'package:silverguard/silverguard.dart';
import 'package:silverguard/src/core/webview/error_page.dart';
import 'package:silverguard/src/core/webview/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCAMWidget extends StatefulWidget {
  final Future<String> Function() loadUrl;
  final OnBackCallback? onBackCallback;
  final Webview? webview;

  const WebviewCAMWidget({
    required this.loadUrl,
    this.onBackCallback,
    this.webview,
    super.key,
  });

  @override
  State<WebviewCAMWidget> createState() => _WebviewCAMWidgetState();
}

class _WebviewCAMWidgetState extends State<WebviewCAMWidget> {
  late final Webview webView;

  @override
  void initState() {
    super.initState();

    webView =
        widget.webview ??
        Webview(
          WebViewController(onPermissionRequest: (request) => request.grant()),
          context,
          onBackCallback: widget.onBackCallback,
        );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: widget.loadUrl(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (snapshot.hasError || snapshot.data == null) {
        return ErrorPage(onBackCallback: widget.onBackCallback);
      }
      webView.config(snapshot.data!);
      return Scaffold(body: SafeArea(child: webView.open()));
    },
  );
}
