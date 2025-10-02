import 'package:flutter/material.dart';

class SilverguardTheme {
  final SilverguardThemeTextStyles textStyle;
  final SilverguardThemeColors colors;

  SilverguardTheme({
    SilverguardThemeTextStyles? textStyle,
    SilverguardThemeColors? colors,
  }) : textStyle = textStyle ?? SilverguardThemeTextStyles(),
       colors = colors ?? SilverguardThemeColors();
}

class SilverguardThemeTextStyles {
  TextStyle get button => TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get body => TextStyle(fontSize: 14);
  TextStyle get headline2 => TextStyle(fontSize: 24);
  TextStyle get headline3 => TextStyle(fontSize: 20);
}

class SilverguardThemeColors {
  Color get background => Color(0xFFFFFFFF);

  Color get primary => Color(0xFF1B264F);
  Color get primary04 => primary.withAlpha(40);

  Color get label => Color(0xFF282828);

  Color get buttonTitle => Color(0xFFFEFEFE);
  Color get buttonEnabled => Color(0xFF1B264F);
  Color get buttonDisabled => Color(0xFF767D95);
}
