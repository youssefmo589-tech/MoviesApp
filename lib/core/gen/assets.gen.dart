// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Roboto-Bold.ttf
  String get robotoBold => 'assets/fonts/Roboto-Bold.ttf';

  /// File path: assets/fonts/Roboto-Medium.ttf
  String get robotoMedium => 'assets/fonts/Roboto-Medium.ttf';

  /// File path: assets/fonts/Roboto-Regular.ttf
  String get robotoRegular => 'assets/fonts/Roboto-Regular.ttf';

  /// File path: assets/fonts/Roboto-SemiBold.ttf
  String get robotoSemiBold => 'assets/fonts/Roboto-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    robotoBold,
    robotoMedium,
    robotoRegular,
    robotoSemiBold,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/email icon.svg
  SvgGenImage get emailIcon => const SvgGenImage('assets/icons/email icon.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/name.svg
  SvgGenImage get name => const SvgGenImage('assets/icons/name.svg');

  /// File path: assets/icons/password.svg
  SvgGenImage get password => const SvgGenImage('assets/icons/password.svg');

  /// File path: assets/icons/passwordeye.svg
  SvgGenImage get passwordeye =>
      const SvgGenImage('assets/icons/passwordeye.svg');

  /// File path: assets/icons/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/icons/phone.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    emailIcon,
    google,
    name,
    password,
    passwordeye,
    phone,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/EG.png
  AssetGenImage get eg => const AssetGenImage('assets/images/EG.png');

  /// File path: assets/images/Forgot password-bro 1.png
  AssetGenImage get forgotPasswordBro1 =>
      const AssetGenImage('assets/images/Forgot password-bro 1.png');

  /// File path: assets/images/LR.png
  AssetGenImage get lr => const AssetGenImage('assets/images/LR.png');

  /// File path: assets/images/gamer (1) (1).png
  AssetGenImage get gamer11 =>
      const AssetGenImage('assets/images/gamer (1) (1).png');

  /// File path: assets/images/gamer (1) (2).png
  AssetGenImage get gamer12 =>
      const AssetGenImage('assets/images/gamer (1) (2).png');

  /// File path: assets/images/gamer (1) (3).png
  AssetGenImage get gamer13 =>
      const AssetGenImage('assets/images/gamer (1) (3).png');

  /// File path: assets/images/gamer (1) (4).png
  AssetGenImage get gamer14 =>
      const AssetGenImage('assets/images/gamer (1) (4).png');

  /// File path: assets/images/gamer (1) (5).png
  AssetGenImage get gamer15 =>
      const AssetGenImage('assets/images/gamer (1) (5).png');

  /// File path: assets/images/gamer (1) (6).png
  AssetGenImage get gamer16 =>
      const AssetGenImage('assets/images/gamer (1) (6).png');

  /// File path: assets/images/gamer (1) (7).png
  AssetGenImage get gamer17 =>
      const AssetGenImage('assets/images/gamer (1) (7).png');

  /// File path: assets/images/gamer (1) (8).png
  AssetGenImage get gamer18 =>
      const AssetGenImage('assets/images/gamer (1) (8).png');

  /// File path: assets/images/gamer (1).png
  AssetGenImage get gamer1 =>
      const AssetGenImage('assets/images/gamer (1).png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    eg,
    forgotPasswordBro1,
    lr,
    gamer11,
    gamer12,
    gamer13,
    gamer14,
    gamer15,
    gamer16,
    gamer17,
    gamer18,
    gamer1,
    logo,
  ];
}

abstract final class Assets {
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
