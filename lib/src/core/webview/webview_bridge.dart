import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:silverguard/src/silverguard/silverguard_bridge.dart';
import 'package:webview_flutter/webview_flutter.dart';

extension ToWebviewCommand on JavaScriptMessage {
  WebviewCommand get webviewCommand {
    final json = jsonDecode(message);
    return WebviewCommand.values.firstWhere(
      (command) => command.value == json["command"],
      orElse: () => WebviewCommand.unknown,
    );
  }

  String get origin => jsonDecode(message)["origin"] ?? "";
}

enum WebviewCommand {
  requestMicrophonePermission('requestMicrophonePermission'),
  requestLibraryPermission('requestLibraryPermission'),
  back('back'),
  unknown('unknown');

  final String value;

  const WebviewCommand(this.value);
}

mixin WebviewBridge {
  BuildContext get context;
  SilverguardBridge? get silverguardBridge;

  SilverguardPermissionBridge? get permissionBridge =>
      (silverguardBridge != null &&
          silverguardBridge is SilverguardPermissionBridge)
      ? (silverguardBridge as SilverguardPermissionBridge)
      : null;

  void addJavaScriptChannels(WebViewController controller) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'AndroidBridge',
        onMessageReceived: (JavaScriptMessage message) {
          try {
            switch (message.webviewCommand) {
              case WebviewCommand.requestMicrophonePermission:
                _requestMicrophonePermission();
                break;
              case WebviewCommand.requestLibraryPermission:
                _requestLibraryPermission();
                break;
              case WebviewCommand.back:
                _onBackCommand(context, message.origin);
                break;
              default:
                _onUnkownCommand(message.message);
            }
          } catch (_) {}
        },
      );
  }

  void _checkStatus(PermissionStatus status) {
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _requestMicrophonePermission() async {
    if (permissionBridge != null) {
      return permissionBridge?.onRequestMicrophonePermission();
    }
    final status = await Permission.microphone.request();
    _checkStatus(status);
  }

  Future<void> _requestLibraryPermission() async {
    if (permissionBridge != null) {
      return permissionBridge?.onRequestLibraryPermission();
    }
    final status = await Permission.mediaLibrary.request();
    _checkStatus(status);
  }

  void _onBackCommand(BuildContext context, String origin) async {
    silverguardBridge?.onBackCallback(origin);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _onUnkownCommand(String command) async {
    silverguardBridge?.onCommandCallback(command);
  }
}
