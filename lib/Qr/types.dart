import 'dart:ui';

import 'package:flutter/widgets.dart';

enum QrCodeElement {
  finderPatternOuter,

  finderPatternInner,

  finderPatternDot,

  codePixel,

  codePixelEmpty,
}

enum FinderPatternPosition {
  topLeft,

  topRight,

  bottomLeft,
}

enum QrEyeShape {
  square,

  circle,
}

enum QrDataModuleShape {
  square,

  circle,
}

class QrEyeStyle {
  const QrEyeStyle({this.eyeShape, this.color});

  final QrEyeShape? eyeShape;

  final Color? color;

  @override
  int get hashCode => eyeShape.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is QrEyeStyle) {
      return eyeShape == other.eyeShape && color == other.color;
    }
    return false;
  }
}

class QrDataModuleStyle {
  const QrDataModuleStyle({
    this.dataModuleShape,
    this.color,
  });

  final QrDataModuleShape? dataModuleShape;

  final Color? color;

  @override
  int get hashCode => dataModuleShape.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is QrDataModuleStyle) {
      return dataModuleShape == other.dataModuleShape && color == other.color;
    }
    return false;
  }
}

class QrEmbeddedImageStyle {
  QrEmbeddedImageStyle({
    this.size,
    this.color,
  });

  Size? size;

  Color? color;

  bool get hasDefinedSize => size != null && size!.longestSide > 0;

  @override
  int get hashCode => size.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is QrEmbeddedImageStyle) {
      return size == other.size && color == other.color;
    }
    return false;
  }
}
