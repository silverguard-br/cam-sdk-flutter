import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/src/core/webview/error_page.dart';

void main() {
  group('ErrorPage', () {
    testWidgets('renders all static texts and widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: ErrorPage(onBackCallback: null)),
      );

      expect(find.text('Contextação via MED'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(
        find.text(
          'Infelizmente não podemos seguir com sua contextação via MED',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Fale conosco através dos nossos canais de atendimento.'),
        findsOneWidget,
      );
      expect(find.text('Finalizar'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('calls onBackPressed and pops when close icon is tapped', (
      WidgetTester tester,
    ) async {
      bool callbackCalled = false;
      BuildContext? callbackContext;
      String? callbackArg;

      void onBack(String arg) {
        callbackCalled = true;
        callbackArg = arg;
      }

      await tester.pumpWidget(
        MaterialApp(home: ErrorPage(onBackCallback: onBack)),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(callbackCalled, isTrue);
      expect(callbackArg, '');
      expect(callbackContext, isNotNull);
    });

    testWidgets(
      'calls onBackPressed and pops when Finalizar button is tapped',
      (WidgetTester tester) async {
        bool callbackCalled = false;

        void onBack(String arg) {
          callbackCalled = true;
        }

        await tester.pumpWidget(
          MaterialApp(home: ErrorPage(onBackCallback: onBack)),
        );

        await tester.tap(find.text('Finalizar'));
        await tester.pumpAndSettle();

        expect(callbackCalled, isTrue);
      },
    );

    testWidgets('pops without error if onBackPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: ErrorPage(onBackCallback: null)),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // No exception means success
      expect(find.byType(ErrorPage), findsNothing);
    });
  });
}
