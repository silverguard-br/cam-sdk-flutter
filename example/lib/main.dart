import 'dart:math';

import 'package:example/custom_bridge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silverguard/silverguard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(title: 'Teste'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final customBridge = CustomBridge();
  final customBridgeWithPermission = CustomBridgeWithPermission();

  @override
  void initState() {
    super.initState();
    SilverguardCAM.init(
      apiKey: '3|14sa2lC4r0jEKLqUpBWcGowIbkt30ziyNJqWvniQ49b50f69',
      baseUrl: 'https://test.camapi.sosgolpe.com.br',
    );
  }

  String generateRandomId({int length = 10}) {
    const allowedChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return List.generate(
      length,
      (index) => allowedChars[Random().nextInt(allowedChars.length)],
    ).join();
  }

  @override
  Widget build(BuildContext context) {
    String transactionTime = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now().subtract(const Duration(days: 5)));

    return Scaffold(
      appBar: AppBar(title: const Text('Silverguard CAM')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            _Button(
              onPressed: () {
                SilverguardCAM.getRequestUrlModel(
                  context,
                  RequestUrlModel(
                    transactionId: generateRandomId(),
                    transactionAmount: 150.0,
                    transactionTime: transactionTime,
                    transactionDescription: "Pagamento via PIX",
                    reporterClientName: "John Doe",
                    reporterClientId: '123456789',
                    contestedParticipantId: "123456",
                    counterpartyClientName: "Maria dos Santos",
                    counterpartyClientId: '987654321',
                    counterpartyClientKey: "DEST_KEY_1",
                    protocolId: "PROT_2025_001",
                    pixAuto: true,
                    clientId: "CLI_456789",
                    clientSince: "2020-01-15",
                    clientBirth: "1985-03-22",
                    autofraudRisk: true,
                    reporterBranchNumber: "1234",
                    reporterAccountNumber: "12345678",
                  ),
                );
              },
              title: 'Get Request URL',
            ),
            _Button(
              onPressed: () {
                SilverguardCAM.showList(
                  context,
                  RequestListUrlModel(
                    reporterClientId: "12345678901",
                    reporterBranchNumber: "1234",
                    reporterAccountNumber: "12345678",
                  ),
                );
              },
              title: 'Show List',
            ),
            _Button(
              onPressed: () =>
                  SilverguardCAM.setSilverguardBridge(customBridge),
              title: 'Add Custom Bridge',
            ),
            _Button(
              onPressed: () =>
                  SilverguardCAM.setSilverguardBridge(customBridge),
              title: 'Add Custom Bridge With Permission',
            ),
            _Button(
              onPressed: () => SilverguardCAM.setSilverguardBridge(null),
              title: 'Remove custom bridge',
            ),
            _Button(
              onPressed: () => SilverguardCAM.setSilverGuardTheme(
                SilverguardTheme(
                  colors: SilverguardThemeColors(
                    background: Colors.grey[300]!,
                    primary: Colors.red,
                    label: Colors.white,
                    buttonTitle: Colors.white,
                    buttonEnabled: Colors.red,
                    buttonDisabled: Colors.blueGrey,
                  ),
                  textStyle: SilverguardThemeTextStyles(
                    button: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    body: TextStyle(fontSize: 16),
                    headline2: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    headline3: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              title: 'Add Custom Theme',
            ),
            _Button(
              onPressed: () => SilverguardCAM.setSilverGuardTheme(null),
              title: 'Remove custom theme',
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const _Button({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
