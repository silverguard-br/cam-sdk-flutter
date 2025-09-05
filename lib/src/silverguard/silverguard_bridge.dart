abstract interface class SilverguardBridge {
  void onBackCallback(String origin);

  void onCommandCallback(String command);
}

abstract interface class SilverguardPermissionBridge extends SilverguardBridge {
  void onRequestMicrophonePermission();

  void onRequestLibraryPermission();
}
