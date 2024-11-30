import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrRepository {
  QrCode generateQrImage(String data) {
    return QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(data);
  }
}
