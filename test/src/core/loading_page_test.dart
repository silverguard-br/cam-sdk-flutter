import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/silverguard.dart';
import 'package:silverguard/src/core/webview/pages/loading_page.dart';

import '../golden.dart';

Widget getBuilder({SilverguardTheme? silverguardTheme}) => Scaffold(
  body: LoadingPage(silverguardTheme: silverguardTheme ?? SilverguardTheme()),
);

Future<void> pump(
  WidgetTester tester, {
  SilverguardTheme? silverguardTheme,
}) async {
  await tester.pumpWidget(
    MaterialApp(home: getBuilder(silverguardTheme: silverguardTheme)),
  );
}

void main() {
  group('ErrorPage', () {
    testGolden(
      'Should render successfully',
      fileName: 'loading_page',
      pumpBeforeTest: (tester) => tester.pump(Duration(seconds: 1)),
      builder: getBuilder(),
    );

    testGolden(
      'Should render with custom theme',
      fileName: 'loading_page_custom_theme',
      pumpBeforeTest: (tester) => tester.pump(Duration(seconds: 1)),
      builder: getBuilder(
        silverguardTheme: SilverguardTheme(
          textStyle: SilverguardThemeTextStyles(
            button: TextStyle(fontSize: 14),
            body: TextStyle(fontSize: 20),
            headline2: TextStyle(fontSize: 18),
            headline3: TextStyle(fontSize: 16),
          ),
          colors: SilverguardThemeColors(
            background: Colors.grey,
            primary: Colors.red,
            label: Colors.blueGrey,
            buttonTitle: Colors.white,
            buttonEnabled: Colors.red,
            buttonDisabled: Colors.grey,
          ),
        ),
      ),
    );
  });
}
