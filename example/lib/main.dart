import 'dart:math';

import 'package:flutter/material.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Silverguard CAM')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                SilverguardCAM.getRequestUrlModel(
                  context,
                  RequestUrlModel(
                    transactionId: generateRandomId(),
                    transactionAmount: 150.0,
                    transactionTime: "2025-07-11 11:10:00",
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
                  ),
                );
              },
              child: const Text('Get Request URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                SilverguardCAM.showList(
                  context,
                  RequestListUrlModel(reporterClientId: "12345678901"),
                );
              },
              child: const Text('Show List'),
            ),
          ],
        ),
      ),
    );
  }
}
