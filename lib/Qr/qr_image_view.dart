import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:qr/qr.dart';

import 'qr_painter.dart';
import 'qr_versions.dart';
import 'types.dart';
import 'validator.dart';

class QrImageView extends StatefulWidget {
  QrImageView({
    required String data,
    Key? key,
    this.size,
    this.padding = const EdgeInsets.all(10.0),
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.version = QrVersions.auto,
    this.errorCorrectionLevel = QrErrorCorrectLevel.L,
    this.errorStateBuilder,
    this.constrainErrorBounds = true,
    this.gapless = true,
    this.embeddedImage,
    this.embeddedImageStyle,
    this.semanticsLabel = 'qr code',
    this.eyeStyle = const QrEyeStyle(
      eyeShape: QrEyeShape.square,
      color: Colors.black,
    ),
    this.dataModuleStyle = const QrDataModuleStyle(
      dataModuleShape: QrDataModuleShape.square,
      color: Colors.black,
    ),
    this.embeddedImageEmitsError = false,
  })  : assert(QrVersions.isSupportedVersion(version)),
        _data = data,
        _qrCode = null,
        super(key: key);

  QrImageView.withQr({
    required QrCode qr,
    Key? key,
    this.size,
    this.padding = const EdgeInsets.all(10.0),
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.version = QrVersions.auto,
    this.errorCorrectionLevel = QrErrorCorrectLevel.L,
    this.errorStateBuilder,
    this.constrainErrorBounds = true,
    this.gapless = true,
    this.embeddedImage,
    this.embeddedImageStyle,
    this.semanticsLabel = 'qr code',
    this.eyeStyle = const QrEyeStyle(
      eyeShape: QrEyeShape.square,
      color: Colors.black,
    ),
    this.dataModuleStyle = const QrDataModuleStyle(
      dataModuleShape: QrDataModuleShape.square,
      color: Colors.black,
    ),
    this.embeddedImageEmitsError = false,
  })  : assert(QrVersions.isSupportedVersion(version)),
        _data = null,
        _qrCode = qr,
        super(key: key);

  final String? _data;

  final QrCode? _qrCode;

  final Color backgroundColor;

  @Deprecated('use colors in eyeStyle and dataModuleStyle instead')
  final Color? foregroundColor;

  final int version;

  final int errorCorrectionLevel;

  final EdgeInsets padding;

  final double? size;

  final QrErrorBuilder? errorStateBuilder;

  final bool constrainErrorBounds;

  final bool gapless;

  final ImageProvider? embeddedImage;

  final QrEmbeddedImageStyle? embeddedImageStyle;

  final bool embeddedImageEmitsError;

  final String semanticsLabel;

  final QrEyeStyle eyeStyle;

  final QrDataModuleStyle dataModuleStyle;

  @override
  _QrImageViewState createState() => _QrImageViewState();
}

class _QrImageViewState extends State<QrImageView> {
  QrCode? _qr;

  late QrValidationResult _validationResult;

  @override
  Widget build(BuildContext context) {
    if (widget._data != null) {
      _validationResult = QrValidator.validate(
        data: widget._data!,
        version: widget.version,
        errorCorrectionLevel: widget.errorCorrectionLevel,
      );
      if (_validationResult.isValid) {
        _qr = _validationResult.qrCode;
      } else {
        _qr = null;
      }
    } else if (widget._qrCode != null) {
      _qr = widget._qrCode;
      _validationResult =
          QrValidationResult(status: QrValidationStatus.valid, qrCode: _qr);
    }
    return LayoutBuilder(builder: (context, constraints) {
      if (!_validationResult.isValid) {
        return _errorWidget(context, constraints, _validationResult.error);
      }
      final widgetSize = widget.size ?? constraints.biggest.shortestSide;
      if (widget.embeddedImage != null) {
        return FutureBuilder<ui.Image>(
          future: _loadQrImage(context, widget.embeddedImageStyle),
          builder: (ctx, snapshot) {
            if (snapshot.error != null) {
              print("snapshot error: ${snapshot.error}");
              if (widget.embeddedImageEmitsError) {
                return _errorWidget(context, constraints, snapshot.error);
              } else {
                return _qrWidget(context, null, widgetSize);
              }
            }
            if (snapshot.hasData) {
              print('loaded image');
              final loadedImage = snapshot.data;
              return _qrWidget(context, loadedImage, widgetSize);
            } else {
              return Container();
            }
          },
        );
      } else {
        return _qrWidget(context, null, widgetSize);
      }
    });
  }

  Widget _qrWidget(BuildContext context, ui.Image? image, double edgeLength) {
    final painter = QrPainter.withQr(
      qr: _qr!,
      color: widget.foregroundColor,
      gapless: widget.gapless,
      embeddedImageStyle: widget.embeddedImageStyle,
      embeddedImage: image,
      eyeStyle: widget.eyeStyle,
      dataModuleStyle: widget.dataModuleStyle,
    );
    return _QrContentView(
      edgeLength: edgeLength,
      backgroundColor: widget.backgroundColor,
      padding: widget.padding,
      semanticsLabel: widget.semanticsLabel,
      child: CustomPaint(painter: painter),
    );
  }

  Widget _errorWidget(
      BuildContext context, BoxConstraints constraints, Object? error) {
    final errorWidget = widget.errorStateBuilder == null
        ? Container()
        : widget.errorStateBuilder!(context, error);
    final errorSideLength = (widget.constrainErrorBounds
        ? widget.size ?? constraints.biggest.shortestSide
        : constraints.biggest.longestSide);
    return _QrContentView(
      edgeLength: errorSideLength,
      backgroundColor: widget.backgroundColor,
      padding: widget.padding,
      child: errorWidget,
      semanticsLabel: widget.semanticsLabel,
    );
  }

  late ImageStreamListener streamListener;
  Future<ui.Image> _loadQrImage(
      BuildContext buildContext, QrEmbeddedImageStyle? style) async {
    if (style != null) {}

    final mq = MediaQuery.of(buildContext);
    final completer = Completer<ui.Image>();
    final stream = widget.embeddedImage!.resolve(ImageConfiguration(
      devicePixelRatio: mq.devicePixelRatio,
    ));

    streamListener = ImageStreamListener((info, err) {
      stream.removeListener(streamListener);
      completer.complete(info.image);
    }, onError: (dynamic err, _) {
      stream.removeListener(streamListener);
      completer.completeError(err);
    });
    stream.addListener(streamListener);
    return completer.future;
  }
}

typedef QrErrorBuilder = Widget Function(BuildContext context, Object? error);

class _QrContentView extends StatelessWidget {
  _QrContentView({
    required this.edgeLength,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.semanticsLabel,
  });

  final double edgeLength;

  final Color? backgroundColor;

  final EdgeInsets? padding;

  final Widget child;

  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: Container(
        width: edgeLength,
        height: edgeLength,
        color: backgroundColor,
        child: Padding(
          padding: padding!,
          child: child,
        ),
      ),
    );
  }
}
