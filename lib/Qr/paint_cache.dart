import 'package:flutter/widgets.dart';

import 'types.dart';

class PaintCache {
  final List<Paint> _pixelPaints = <Paint>[];
  final Map<String, Paint> _keyedPaints = <String, Paint>{};

  String _cacheKey(QrCodeElement element, {FinderPatternPosition? position}) {
    final posKey = position != null ? position.toString() : 'any';
    return '${element.toString()}:$posKey';
  }

  void cache(Paint paint, QrCodeElement element,
      {FinderPatternPosition? position}) {
    if (element == QrCodeElement.codePixel) {
      _pixelPaints.add(paint);
    } else {
      _keyedPaints[_cacheKey(element, position: position)] = paint;
    }
  }

  Paint? firstPaint(QrCodeElement element, {FinderPatternPosition? position}) {
    if (element == QrCodeElement.codePixel) {
      return _pixelPaints.first;
    } else {
      return _keyedPaints[_cacheKey(element, position: position)];
    }
  }

  List<Paint?> paints(QrCodeElement element,
      {FinderPatternPosition? position}) {
    if (element == QrCodeElement.codePixel) {
      return _pixelPaints;
    } else {
      return <Paint?>[_keyedPaints[_cacheKey(element, position: position)]];
    }
  }
}
