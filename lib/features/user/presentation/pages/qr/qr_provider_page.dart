import 'package:eunoia_chat_application/features/main/presentation/widgets/container_icon_widget.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/qr/scanner_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

extension _AdvancedContext on BuildContext {
  QrProviderState get state => QrProvider.of(this);
}

class QrProviderPage extends StatelessWidget {
  const QrProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Scaffold(
          appBar: kIsWeb ? AppBar() : null,
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !kIsWeb
                    ? Align(
                        alignment: Alignment.topRight,
                        child: ContainerIconWidget(
                            onTap: () {
                              context.pop();
                            },
                            iconColor: Colors.black,
                            containerColor: Colors.white,
                            icon: 'close-outline'))
                    : const SizedBox(),
                !kIsWeb ? const Spacer() : const SizedBox(),
                Center(
                  child: Container(
                      width: 250,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ValueListenableBuilder(
                              valueListenable: context.state.qrImageNotifier,
                              builder: (context, value, child) {
                                return value == null
                                    ? const CircularProgressIndicator()
                                    : PrettyQrView(
                                        decoration: const PrettyQrDecoration(
                                          image: PrettyQrDecorationImage(
                                              image: AssetImage(
                                                  'assets/eunoia-logo-small.png')),
                                        ),
                                        qrImage: value);
                              }))),
                ),
                const SizedBox(
                  height: 10,
                ),
                !kIsWeb ? const _ScanWidget() : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                !kIsWeb ? const _SaveWidget() : const SizedBox(),
                !kIsWeb ? const Spacer() : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanWidget extends StatelessWidget {
  const _ScanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          await context.state.scan();
          showMaterialModalBottomSheet(
              context: context,
              builder: (_) {
                return ScannerPage(
                  context: context,
                );
              });
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
              ),
              const SizedBox(
                width: 15,
              ),
              Center(
                child: Text(
                  'Scan',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveWidget extends StatelessWidget {
  const _SaveWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.state.saveQrcode();
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.save,
                color: Colors.black,
              ),
              const SizedBox(
                width: 15,
              ),
              Center(
                child: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
