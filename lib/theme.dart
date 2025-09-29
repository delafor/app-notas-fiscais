import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 0, 0, 0),
      surfaceTint: Color.fromARGB(255, 27, 24, 36),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color.fromARGB(255, 117, 116, 119),
      onPrimaryContainer: Color(0xff4d3d75),
      secondary: Color.fromARGB(255, 43, 42, 46),
      onSecondary: Color.fromARGB(255, 190, 190, 190),
      secondaryContainer: Color(0xffe9ddff),
      onSecondaryContainer: Color(0xff4d3d75),
      tertiary: Color.fromARGB(255, 38, 22, 27),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9e3),
      onTertiaryContainer: Color(0xff6f334a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff1d1b20),
      onSurfaceVariant: Color(0xff48454e),
      outline: Color(0xff79757f),
      outlineVariant: Color(0xffcac4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff201047),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff210f47),
      secondaryFixedDim: Color(0xffd0bcfe),
      onSecondaryFixedVariant: Color(0xff4d3d75),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff3a071e),
      tertiaryFixedDim: Color(0xffffb0ca),
      onTertiaryFixedVariant: Color(0xff6f334a),
      surfaceDim: Color(0xffded8e0),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f2fa),
      surfaceContainer: Color(0xfff2ecf4),
      surfaceContainerHigh: Color(0xffece6ee),
      surfaceContainerHighest: Color(0xffe6e0e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c2d63),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff74649f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3c2c63),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff74649e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5b2239),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9c5870),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff121016),
      onSurfaceVariant: Color(0xff38353d),
      outline: Color(0xff54515a),
      outlineVariant: Color(0xff6f6b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xff74649f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5b4c84),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff74649e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5b4b84),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9c5870),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff804058),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcac5cc),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f2fa),
      surfaceContainer: Color(0xffece6ee),
      surfaceContainerHigh: Color(0xffe1dbe3),
      surfaceContainerHighest: Color(0xffd5d0d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff312259),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4f4078),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff322258),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff504078),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4f182f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff72354c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2b33),
      outlineVariant: Color(0xff4b4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xff4f4078),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff382960),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff504078),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff38295f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff72354c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff571f35),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbcb7bf),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5eff7),
      surfaceContainer: Color(0xffe6e0e9),
      surfaceContainerHigh: Color(0xffd8d2da),
      surfaceContainerHighest: Color(0xffcac5cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcfbdfe),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff36275d),
      primaryContainer: Color(0xff4d3d75),
      onPrimaryContainer: Color(0xffe9ddff),
      secondary: Color(0xffd0bcfe),
      onSecondary: Color(0xff36265d),
      secondaryContainer: Color(0xff4d3d75),
      onSecondaryContainer: Color(0xffe9ddff),
      tertiary: Color(0xffffb0ca),
      onTertiary: Color(0xff541d33),
      tertiaryContainer: Color(0xff6f334a),
      onTertiaryContainer: Color(0xffffd9e3),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141218),
      onSurface: Color(0xffe6e0e9),
      onSurfaceVariant: Color(0xffcac4cf),
      outline: Color(0xff938f99),
      outlineVariant: Color(0xff48454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0e9),
      inversePrimary: Color(0xff65558f),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff201047),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff210f47),
      secondaryFixedDim: Color(0xffd0bcfe),
      onSecondaryFixedVariant: Color(0xff4d3d75),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff3a071e),
      tertiaryFixedDim: Color(0xffffb0ca),
      onTertiaryFixedVariant: Color(0xff6f334a),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff3b383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1d1b20),
      surfaceContainer: Color(0xff211f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe3d6ff),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff2b1b52),
      primaryContainer: Color(0xff9887c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe3d6ff),
      onSecondary: Color(0xff2b1b51),
      secondaryContainer: Color(0xff9987c5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd0dd),
      onTertiary: Color(0xff471228),
      tertiaryContainer: Color(0xffc57b94),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0dae5),
      outline: Color(0xffb5b0bb),
      outlineVariant: Color(0xff938e99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0e9),
      inversePrimary: Color(0xff4e3f77),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff16033d),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff3c2d63),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff16033c),
      secondaryFixedDim: Color(0xffd0bcfe),
      onSecondaryFixedVariant: Color(0xff3c2c63),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff2b0013),
      tertiaryFixedDim: Color(0xffffb0ca),
      onTertiaryFixedVariant: Color(0xff5b2239),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff46434a),
      surfaceContainerLowest: Color(0xff08070b),
      surfaceContainerLow: Color(0xff1f1d22),
      surfaceContainer: Color(0xff29272d),
      surfaceContainerHigh: Color(0xff343138),
      surfaceContainerHighest: Color(0xff3f3c43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5edff),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcbb9fa),
      onPrimaryContainer: Color(0xff0f0033),
      secondary: Color(0xfff5edff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffccb9fa),
      onSecondaryContainer: Color(0xff100032),
      tertiary: Color(0xffffebef),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfffdabc6),
      onTertiaryContainer: Color(0xff20000d),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4eef9),
      outlineVariant: Color(0xffc6c0cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0e9),
      inversePrimary: Color(0xff4e3f77),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff16033d),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd0bcfe),
      onSecondaryFixedVariant: Color(0xff16033c),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb0ca),
      onTertiaryFixedVariant: Color(0xff2b0013),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff524f55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff211f24),
      surfaceContainer: Color(0xff322f35),
      surfaceContainerHigh: Color(0xff3d3a41),
      surfaceContainerHighest: Color(0xff48464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
