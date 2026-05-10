import 'package:flutter/material.dart';

class HorrorTheme extends ThemeExtension<HorrorTheme> {
  final Color? bloodRed;
  final Color? moldGreen;
  final TextStyle? horrorTitle;

  const HorrorTheme({this.bloodRed, this.moldGreen, this.horrorTitle});

  @override
  HorrorTheme copyWith({
    Color? bloodRed,
    Color? moldGreen,
    TextStyle? horrorTitle,
  }) {
    return HorrorTheme(
      bloodRed: bloodRed ?? this.bloodRed,
      moldGreen: moldGreen ?? this.moldGreen,
      horrorTitle: horrorTitle ?? this.horrorTitle,
    );
  }

  @override
  HorrorTheme lerp(ThemeExtension<HorrorTheme>? other, double t) {
    if (other is! HorrorTheme) return this;
    return HorrorTheme(
      bloodRed: Color.lerp(bloodRed, other.bloodRed, t),
      moldGreen: Color.lerp(moldGreen, other.moldGreen, t),
      horrorTitle: TextStyle.lerp(horrorTitle, other.horrorTitle, t),
    );
  }

  // DEFINIZIONE DEI COLORI ACCESI (Neon/Glow)
  static const horrorExtension = HorrorTheme(
    bloodRed: Color(0xFFFF0000), // Rosso puro "Super Neon"
    moldGreen: Color(0xFF00FF41), // Verde Matrix / Neon
    horrorTitle: TextStyle(
      color: Color(0xFFFF0000),
      fontSize: 24,
      fontWeight: FontWeight.w900,
      letterSpacing: 2,
      // Bagliore integrato nel font
      shadows: [Shadow(color: Color(0xFFFF0000), blurRadius: 12)],
    ),
  );
}
