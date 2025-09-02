extension BaseUrlExtension on String {
  String get removeHttp {
    var result = this;
    if (startsWith('http://') || startsWith('https://')) {
      result = replaceFirst(RegExp(r'^https?://'), '');
    }
    if (endsWith('/')) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }
}
