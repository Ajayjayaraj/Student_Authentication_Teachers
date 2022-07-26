import 'package:qr/qr.dart';

import 'qr_versions.dart';

class QrValidator {
  static QrValidationResult validate({
    required String data,
    int version = QrVersions.auto,
    int errorCorrectionLevel = QrErrorCorrectLevel.L,
  }) {
    late final QrCode qrCode;
    try {
      if (version != QrVersions.auto) {
        qrCode = QrCode(version, errorCorrectionLevel);
        qrCode.addData(data);
      } else {
        qrCode = QrCode.fromData(
          data: data,
          errorCorrectLevel: errorCorrectionLevel,
        );
      }
      return QrValidationResult(
          status: QrValidationStatus.valid, qrCode: qrCode);
    } on InputTooLongException catch (itle) {
      return QrValidationResult(
          status: QrValidationStatus.contentTooLong, error: itle);
    } on Exception catch (ex) {
      return QrValidationResult(status: QrValidationStatus.error, error: ex);
    }
  }
}

class QrValidationResult {
  QrValidationResult({required this.status, this.qrCode, this.error});

  QrValidationStatus status;

  QrCode? qrCode;

  Exception? error;

  bool get isValid => status == QrValidationStatus.valid;
}

enum QrValidationStatus {
  valid,

  contentTooLong,

  error,
}
