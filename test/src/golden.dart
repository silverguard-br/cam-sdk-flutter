import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@isTest
void testGolden(
  String description, {
  required String fileName,
  required Widget builder,
  Future<void> Function(WidgetTester)? pumpBeforeTest,
}) => goldenTest(
  description,
  fileName: fileName,
  pumpBeforeTest: pumpBeforeTest ?? onlyPumpAndSettle,
  builder: () => GoldenTestScenario(
    constraints: BoxConstraints(maxHeight: 800, maxWidth: 400),
    name: 'mobile',
    child: MaterialApp(debugShowCheckedModeBanner: false, home: builder),
  ),
);
