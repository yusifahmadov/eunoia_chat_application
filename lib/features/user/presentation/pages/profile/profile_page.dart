import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/encryption/diffie_hellman_encryption.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/constants.dart';
import '../../../../../core/constant/empty_box.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../../../../main/presentation/widgets/custom_svg_icon.dart';
import '../../cubit/user_cubit.dart';
import 'profile_page_provider.dart';
import 'profile_page_provider_state.dart';

extension _AdvancedContext on BuildContext {
  ProfilePageProviderState get state => ProfilePageProvider.of(this);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          bloc: context.state.userCubit,
          builder: (context, state) {
            if (state is CurrentUserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CurrentUserError) {
              return Center(child: Text(state.message));
            } else if (state is CurrentUserSuccess) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    centerTitle: false,
                    actions: [
                      Text(
                        context.localization?.edit ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                    title: GestureDetector(
                        onTap: () {
                          authCubit.logout();
                        },
                        child: const CustomSvgIcon(text: 'qr-code-outline')),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: context.state.profilePhotoNotifier,
                            builder: (context, value, child) {
                              return CachedNetworkImage(
                                imageUrl: '${state.user.profilePhoto}',
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: value != null
                                            ? AssetImage(value.path)
                                            : imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${state.user.name}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '@${state.user.username}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const EmptyHeightBox(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  context.state.updateProfilePhoto();
                                },
                                minTileHeight: 50,
                                leading: const CustomSvgIcon(text: 'camera-outline'),
                                title: Text(
                                    context.localization?.change_profile_photo ?? ""),
                              ),
                              const EmptyHeightBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      showDragHandle: true,
                                      builder: (context) {
                                        return const LanguageProviderWidget();
                                      });
                                },
                                minTileHeight: 50,
                                leading: CustomSvgIcon(
                                  text: 'language-outline',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(context.localization?.change_language ?? ""),
                              ),
                              const EmptyHeightBox(
                                height: 30,
                              ),
                              BlocListener<AuthenticationCubit, AuthenticationState>(
                                bloc: authCubit,
                                listener: (context, state) {
                                  if (state is AuthenticationUnauthenticated) {
                                    context.pushReplacement('/auth');
                                  }
                                },
                                child: ListTile(
                                    onTap: () => authCubit.logout(),
                                    minTileHeight: 50,
                                    leading: CustomSvgIcon(
                                      text: 'log-out-outline',
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                    title: Text(
                                      context.localization?.logout ?? "",
                                    )),
                              ),
                              ListTile(
                                onTap: () {
                                  DiffieHellmanEncryption diffieHellmanEncryption =
                                      DiffieHellmanEncryption();
                                  diffieHellmanEncryption.secureChatExample();
                                },
                                minTileHeight: 50,
                                leading: CustomSvgIcon(
                                  text: 'language-outline',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text("Diffie Hellman Key Exchange"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
