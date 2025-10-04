import 'package:flutter/material.dart';
import 'package:silverguard/src/core/webview/pages/error_page.dart';
import 'package:silverguard/src/core/webview/pages/loading_page.dart';
import 'package:silverguard/src/core/webview/webview.dart';
import 'package:silverguard/src/silverguard/silverguard_bridge.dart';
import 'package:silverguard/src/silverguard/silverguard_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCAMWidget extends StatefulWidget {
  final Future<String> Function() loadUrl;
  final SilverguardBridge? silverguardBridge;
  final SilverguardTheme silverguardTheme;
  final Webview? webview;

  const WebviewCAMWidget({
    required this.loadUrl,
    required this.silverguardTheme,
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
  Widget build(BuildContext context) => PageBase(
    silverguardTheme: widget.silverguardTheme,
    child: FutureBuilder(
      future: widget.loadUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage(silverguardTheme: widget.silverguardTheme);
        } else if (snapshot.hasError || snapshot.data == null) {
          return ErrorPage(
            onBackCallback: widget.silverguardBridge?.onBackCallback,
            silverguardTheme: widget.silverguardTheme,
          );
        }
        webView.config(snapshot.data!);
        return webView.open();
      },
    ),
  );
}

class PageBase extends StatelessWidget {
  final Widget child;
  final SilverguardTheme silverguardTheme;

  const PageBase({
    required this.child,
    required this.silverguardTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: silverguardTheme.colors.background,
      body: SafeArea(child: child),
    );
  }
}
