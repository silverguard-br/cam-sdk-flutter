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

class _WebviewCAMWidgetState extends State<WebviewCAMWidget>
    with AutomaticKeepAliveClientMixin {
  late final Webview webView;
  late Future<String> _loadUrlFuture;
  bool loaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadUrlFuture = widget.loadUrl();

    webView =
        widget.webview ??
        Webview(
          WebViewController(onPermissionRequest: (request) => request.grant()),
          context,
          silverguardBridge: widget.silverguardBridge,
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageBase(
      silverguardTheme: widget.silverguardTheme,
      child: FutureBuilder(
        future: _loadUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (!loaded) {
                webView.config(snapshot.data!);
                loaded = true;
              }
              return webView.open();
            } else {
              return ErrorPage(
                onBackCallback: widget.silverguardBridge?.onBackCallback,
                silverguardTheme: widget.silverguardTheme,
              );
            }
          }
          return LoadingPage(silverguardTheme: widget.silverguardTheme);
        },
      ),
    );
  }
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
