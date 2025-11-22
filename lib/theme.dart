import 'package:flutter/material.dart';

class AppThemes {
  // LIGHT ==================================================
  static ThemeData light() {
    const colors = ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 255, 255, 255),
      onPrimary: Color.fromARGB(255, 98, 78, 150),

      primaryContainer: Colors.orange,
      onPrimaryContainer: Colors.white,

      secondary: Color.fromARGB(202, 0, 0, 0),
      onSecondary: Color.fromARGB(255, 190, 190, 190),

      tertiary: Color.fromARGB(255, 38, 22, 27),
      onTertiary: Colors.white,

      error: Color(0xffba1a1a),
      onError: Colors.white,

      surface: Colors.white,
      onSurface: Color(0xff1d1b20),

      background: Color(0xfff3f2f8),
      onBackground: Color(0xff1d1b20),

      outline: Color(0xff79757f),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.background,

      cardTheme: CardThemeData(
        color: colors.primary,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // DARK ====================================================
  static ThemeData dark() {
    const colors = ColorScheme(
      brightness: Brightness.dark,

      primary: Color.fromARGB(255, 43, 42, 46),
      onPrimary: Colors.white,

      primaryContainer: Colors.orange,
      onPrimaryContainer: Colors.white,

      secondary: Color.fromARGB(255, 98, 78, 150),
      onSecondary: Colors.white,

      tertiary: Color(0xffffb0ca),
      onTertiary: Color(0xff3a071e),

      error: Color(0xffffb4ab),
      onError: Color(0xff690005),

      surface: Color(0xff1a171e),
      onSurface: Colors.white,

      background: Color(0xff121013),
      onBackground: Colors.white,

      outline: Color(0xff908b96),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.background,

      cardTheme: CardThemeData(
        color: colors.primary,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
