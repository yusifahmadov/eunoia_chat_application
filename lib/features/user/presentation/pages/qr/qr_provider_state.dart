import 'dart:io';

import 'package:eunoia_chat_application/core/flasher/custom_flasher.dart';
import 'package:eunoia_chat_application/core/qr/qr_repository.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/utility/extensions.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrProviderWidget extends StatefulWidget {
  const QrProviderWidget({super.key});

  @override
  State<QrProviderWidget> createState() => QrProviderState();
}

class QrProviderState extends State<QrProviderWidget> {
  final QrRepository qrRepository = QrRepository();
  QRViewController? controller;
  ValueNotifier<QrImage?> qrImageNotifier = ValueNotifier(null);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late final QrImage qrImage;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      qrImage = QrImage(await generateQrCode());
      qrImageNotifier.value = qrImage;
    });

    super.initState();
  }

  generateQrCode() async {
    final User? user = (await SharedPreferencesUserManager.getUser())?.user;

    return qrRepository.generateQrImage(user!.id);
  }

  scan() {}

  checkContact({required String id}) async {
    final Conversation? conversaton = await getIt<ContactCubit>().checkContact(id: id);
    mainContext?.pop();
    mainContext?.pushReplacement('/conversations/details/${conversaton!.id}', extra: [
      (await SharedPreferencesUserManager.getUser())?.user,
      conversaton,
    ]);
  }

  saveQrcode() async {
    await qrImage
        .exportAsImage(
      context,
      size: 512,
      decoration: const PrettyQrDecoration(),
    )
        .whenComplete(() {
      CustomFlasher.showSuccess(
        'QR code saved successfully',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return QrProvider(
      state: this,
      child: const QrProviderPage(),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
