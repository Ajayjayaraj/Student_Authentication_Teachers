import 'package:flutter/widgets.dart';

import 'qr_versions.dart';

class QrUnsupportedVersionException implements Exception {
  factory QrUnsupportedVersionException(int providedVersion) {
    final message =
        'Invalid version. $providedVersion is not >= ${QrVersions.min} '
        'and <= ${QrVersions.max}';
    return QrUnsupportedVersionException._internal(providedVersion, message);
  }

  QrUnsupportedVersionException._internal(this.providedVersion, this.message);

  final int providedVersion;

  final String message;

  @override
  String toString() => 'QrUnsupportedVersionException: $message';
}

class QrEmbeddedImageException implements Exception {
  factory QrEmbeddedImageException(String message) {
    return QrEmbeddedImageException._internal(message);
  }
  QrEmbeddedImageException._internal(this.message);

  final String message;

  @override
  String toString() => 'QrEmbeddedImageException: $message';
}
