import 'package:flutter/material.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color bg;
  final Color bgSoft;
  final Color card;
  final Color card2;
  final Color border;
  final Color text;
  final Color textSoft;
  final Color accent;
  final Color accent2;
  final Color danger;

  const AppThemeColors({
    required this.bg,
    required this.bgSoft,
    required this.card,
    required this.card2,
    required this.border,
    required this.text,
    required this.textSoft,
    required this.accent,
    required this.accent2,
    required this.danger,
  });

  @override
  AppThemeColors copyWith({
    Color? bg,
    Color? bgSoft,
    Color? card,
    Color? card2,
    Color? border,
    Color? text,
    Color? textSoft,
    Color? accent,
    Color? accent2,
    Color? danger,
  }) {
    return AppThemeColors(
      bg: bg ?? this.bg,
      bgSoft: bgSoft ?? this.bgSoft,
      card: card ?? this.card,
      card2: card2 ?? this.card2,
      border: border ?? this.border,
      text: text ?? this.text,
      textSoft: textSoft ?? this.textSoft,
      accent: accent ?? this.accent,
      accent2: accent2 ?? this.accent2,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;

    return AppThemeColors(
      bg: Color.lerp(bg, other.bg, t)!,
      bgSoft: Color.lerp(bgSoft, other.bgSoft, t)!,
      card: Color.lerp(card, other.card, t)!,
      card2: Color.lerp(card2, other.card2, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSoft: Color.lerp(textSoft, other.textSoft, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}

extension AppThemeExtension on BuildContext {
  AppThemeColors get colors {
    return Theme.of(this).extension<AppThemeColors>()!;
  }
}
