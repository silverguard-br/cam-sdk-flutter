import 'package:flutter/material.dart';
import 'package:silverguard/src/silverguard/silverguard_theme.dart';

class ErrorPage extends StatelessWidget {
  final Function(String origin)? onBackCallback;
  final SilverguardTheme silverguardTheme;

  const ErrorPage({
    required this.onBackCallback,
    required this.silverguardTheme,
    super.key,
  });

  void _goBack(BuildContext context) {
    if (onBackCallback != null) {
      onBackCallback?.call('ERROR_PAGE');
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Container(
                  padding: EdgeInsets.all(41),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: silverguardTheme.colors.primary04,
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: 48,
                    color: silverguardTheme.colors.primary,
                  ),
                ),
                Text(
                  'Infelizmente não podemos seguir com sua contestação via MED',
                  textAlign: TextAlign.center,
                  style: silverguardTheme.textStyle.headline3.copyWith(
                    color: silverguardTheme.colors.label,
                  ),
                ),
                Text(
                  'Fale conosco através dos nossos canais de atendimento.',
                  textAlign: TextAlign.center,
                  style: silverguardTheme.textStyle.body.copyWith(
                    color: silverguardTheme.colors.label,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _goBack(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: silverguardTheme.colors.buttonTitle,
                    backgroundColor: silverguardTheme.colors.buttonEnabled,
                    disabledBackgroundColor:
                        silverguardTheme.colors.buttonDisabled,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: Text(
                    'Finalizar',
                    style: silverguardTheme.textStyle.button,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
