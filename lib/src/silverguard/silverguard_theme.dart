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
  final TextStyle button;
  final TextStyle body;
  final TextStyle headline2;
  final TextStyle headline3;

  SilverguardThemeTextStyles({
    TextStyle? button,
    TextStyle? body,
    TextStyle? headline2,
    TextStyle? headline3,
  }) : button = button ?? TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
       body = body ?? TextStyle(fontSize: 14),
       headline2 = headline2 ?? TextStyle(fontSize: 24),
       headline3 = headline3 ?? TextStyle(fontSize: 20);
}

class SilverguardThemeColors {
  final Color background;
  final Color primary;
  final Color label;
  final Color buttonTitle;
  final Color buttonEnabled;
  final Color buttonDisabled;

  SilverguardThemeColors({
    Color? background,
    Color? primary,
    Color? label,
    Color? buttonTitle,
    Color? buttonEnabled,
    Color? buttonDisabled,
  }) : background = background ?? Color(0xFFFFFFFF),
       primary = primary ?? Color(0xFF1B264F),
       label = label ?? Color(0xFF282828),
       buttonTitle = buttonTitle ?? Color(0xFFFEFEFE),
       buttonEnabled = buttonEnabled ?? Color(0xFF1B264F),
       buttonDisabled = buttonDisabled ?? Color(0xFF767D95);

  Color get primary04 => primary.withAlpha(40);
}
