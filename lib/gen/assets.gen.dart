// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  static const AssetGenImage cupomFiscal = AssetGenImage(
    'assets/CupomFiscal.png',
  );
  static const AssetGenImage google = AssetGenImage('assets/Google.png');
  static const AssetGenImage nota = AssetGenImage('assets/Nota.png');
  static const AssetGenImage notaEletronica = AssetGenImage(
    'assets/NotaEletronica.png',
  );
  static const AssetGenImage notaEletronica02 = AssetGenImage(
    'assets/NotaEletronica02.png',
  );
  static const AssetGenImage notaEscudo = AssetGenImage(
    'assets/NotaEscudo.png',
  );
  static const AssetGenImage abraO = AssetGenImage('assets/abraço.jpeg');
  static const AssetGenImage cuide = AssetGenImage('assets/cuide.png');
  static const AssetGenImage flor = AssetGenImage('assets/flor.jpeg');
  static const AssetGenImage golfinho = AssetGenImage('assets/golfinho.png');
  static const AssetGenImage grafico = AssetGenImage('assets/grafico.png');
  static const AssetGenImage lixeira = AssetGenImage('assets/lixeira.png');
  static const AssetGenImage notaFiscal = AssetGenImage(
    'assets/nota-fiscal.png',
  );
  static const AssetGenImage page = AssetGenImage('assets/page.png');
  static const AssetGenImage planeta = AssetGenImage('assets/planeta.png');
  static const AssetGenImage qrcode = AssetGenImage('assets/qrcode.png');
  static const AssetGenImage recicle = AssetGenImage('assets/recicle.png');
  static const AssetGenImage reutilize = AssetGenImage('assets/reutilize.png');

  /// List of all assets
  static List<AssetGenImage> get values => [
    cupomFiscal,
    google,
    nota,
    notaEletronica,
    notaEletronica02,
    notaEscudo,
    abraO,
    cuide,
    flor,
    golfinho,
    grafico,
    lixeira,
    notaFiscal,
    page,
    planeta,
    qrcode,
    recicle,
    reutilize,
  ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
