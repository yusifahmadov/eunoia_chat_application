import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

extension _AdvancedContext on BuildContext {
  QrProviderState get state => QrProvider.of(this);
}

class ScannerPage extends StatelessWidget {
  final BuildContext context;

  const ScannerPage({super.key, required this.context});
  @override
  Widget build(BuildContext _) {
    return Expanded(flex: 4, child: _buildQrView(context));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 500.0;

    return QRView(
      key: context.state.qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 30,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    context.state.controller = controller;
    context.state.controller!.scannedDataStream.listen((scanData) {
      if (scanData.code == null) {
        return;
      }
      context.state.checkContact(id: scanData.code!);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
