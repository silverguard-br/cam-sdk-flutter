import 'package:flutter/material.dart';
import 'package:silverguard/src/core/webview/error_page.dart';
import 'package:silverguard/src/core/webview/webview.dart';
import 'package:silverguard/src/silverguard/silverguard_bridge.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCAMWidget extends StatefulWidget {
  final Future<String> Function() loadUrl;
  final SilverguardBridge? silverguardBridge;
  final Webview? webview;

  const WebviewCAMWidget({
    required this.loadUrl,
    this.silverguardBridge,
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
          silverguardBridge: widget.silverguardBridge,
        );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: widget.loadUrl(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (snapshot.hasError || snapshot.data == null) {
        return ErrorPage(onBackCallback: widget.silverguardBridge?.onBackCallback);
      }
      webView.config(snapshot.data!);
      return Scaffold(body: SafeArea(child: webView.open()));
    },
  );
}
