// ignore_for_file: avoid_print
import 'package:silverguard/silverguard.dart';

class CustomBridge implements SilverguardBridge {
  @override
  void onBackCallback(String origin) {
    print('back callback called | origin: $origin');
  }

  @override
  void onCommandCallback(String command) {
    print('webview callback called | command: $command');
  }
}

class CustomBridgeWithPermission implements SilverguardPermissionBridge {
  @override
  void onBackCallback(String origin) {
    print('back callback called | origin: $origin');
  }

  @override
  void onCommandCallback(String command) {
    print('webview callback called | command: $command');
  }

  @override
  void onRequestLibraryPermission() {
    print('request libary permission called');
  }

  @override
  void onRequestMicrophonePermission() {
    print('request microphone permission called');
  }
}
