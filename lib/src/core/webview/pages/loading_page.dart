import 'package:flutter/material.dart';
import 'package:silverguard/silverguard.dart';

class LoadingPage extends StatelessWidget {
  final SilverguardTheme silverguardTheme;
  const LoadingPage({required this.silverguardTheme, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                silverguardTheme.colors.primary,
              ),
            ),
            Text(
              'Analisando os dados',
              style: silverguardTheme.textStyle.headline2.copyWith(
                color: silverguardTheme.colors.label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
